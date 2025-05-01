import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdManager {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;

  //Cargamos el anuncio de admob

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          _isAdLoaded == false;
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
        completer.complete(true);
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        ad.dispose();
        completer.complete(false);
      },
    );
    _interstitialAd!.show();
    return completer.future;
  }
}
