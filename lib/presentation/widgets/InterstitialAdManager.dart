import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdManager {
  InterstitialAd? _interstitialAd;
  bool isAdLoaded = false;
  bool _isLoading = false;
  int _retryCount = 0;
  static const int _maxRetries = 3;
  static const Duration _initialRetryDelay = Duration(seconds: 5);

  Future<void> loadInterstitialAd() async {
    if (_isLoading || _retryCount >= _maxRetries) return;
    _isLoading = true;

    try {
      await InterstitialAd.load(
        adUnitId: dotenv.env['ADMOB_INTERSTITIAL_ID'] ?? '',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _isLoading = false;
            _retryCount = 0;
            _interstitialAd = ad;
            isAdLoaded = true;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                _interstitialAd = null;
                isAdLoaded = false;
                loadInterstitialAd(); // Precargar siguiente anuncio
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
                _interstitialAd = null;
                isAdLoaded = false;
                loadInterstitialAd();
              },
            );
          },
          onAdFailedToLoad: (error) {
            _isLoading = false;
            isAdLoaded = false;
            debugPrint('Interstitial load failed: $error');

            if (_retryCount < _maxRetries) {
              final delay = _initialRetryDelay * (_retryCount + 1);
              Future.delayed(delay, () {
                _retryCount++;
                loadInterstitialAd();
              });
            } else {
              _retryCount = 0; // Reset para futuros intentos
            }
          },
        ),
      );
    } catch (e) {
      _isLoading = false;
      debugPrint('Error loading interstitial: $e');
    }
  }

  Future<void> preloadAd() async {
    if (!isAdLoaded && !_isLoading) {
      await loadInterstitialAd();
    }
  }

  Future<bool> showInterstitial() async {
    if (_interstitialAd == null) {
      await loadInterstitialAd();
      return false;
    }

    final completer = Completer<bool>();

    try {
      _interstitialAd!.show();
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          completer.complete(true);
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          completer.complete(false);
          ad.dispose();
        },
      );
      return await completer.future;
    } catch (e) {
      debugPrint('Error showing ad: $e');
      return false;
    } finally {
      _interstitialAd = null;
      isAdLoaded = false;
    }
  }
}
