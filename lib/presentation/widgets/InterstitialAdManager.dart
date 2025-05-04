import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdManager {
  InterstitialAd? _interstitialAd;
  bool isAdLoaded = false;

  //Cargamos el anuncio de admob

  Future<void> loadInterstitialAd() async {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          isAdLoaded = true;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          isAdLoaded = false;
          debugPrint('Interstitial failed to load: $error');
        },
      ),
    );
  }

  Future<bool> showIntersticial() async {
    if (_interstitialAd == null) return false;
    final completer = Completer<bool>();
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd == null;
        loadInterstitialAd();
        completer.complete(true);
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        ad.dispose();
        _interstitialAd = null;
        loadInterstitialAd();
        completer.complete(false);
      },
    );
    try {
      _interstitialAd!.show();
      return await completer.future;
    } catch (e) {
      debugPrint('Error $e');
      return false;
    }
  }
}
