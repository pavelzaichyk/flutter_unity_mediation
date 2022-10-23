import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unity_mediation/unity_mediation.dart';

void main() {
  runApp(const UnityMediationExample());
}

class UnityMediationExample extends StatefulWidget {
  const UnityMediationExample({Key? key}) : super(key: key);

  @override
  State<UnityMediationExample> createState() => _UnityMediationExampleState();
}

class _UnityMediationExampleState extends State<UnityMediationExample> {
  bool _showBanner = false;
  bool _rewardedAdloaded = false;
  bool _interstitialAdloaded = false;

  @override
  void initState() {
    super.initState();
    initUnityMediation();
  }

  Future<void> initUnityMediation() async {
    UnityMediation.initialize(
      gameId: AdManager.gameId,
      onComplete: () {
        print('Initialization Complete');
        loadAds();
      },
      onFailed: (error, message) =>
          print('Initialization Failed: $error $message'),
    );
  }

  void loadAds() {
    loadRewardedAd();
    loadInterstitialAd();
  }

  void loadRewardedAd() {
    setState(() {
      _rewardedAdloaded = false;
    });
    UnityMediation.loadRewardedAd(
      adUnitId: AdManager.rewardedAdUnitId,
      onComplete: (adUnitId) {
        print('Rewarded Ad Load Complete $adUnitId');
        setState(() {
          _rewardedAdloaded = true;
        });
      },
      onFailed: (adUnitId, error, message) =>
          print('Rewarded Ad Load Failed $adUnitId: $error $message'),
    );
  }

  void loadInterstitialAd() {
    setState(() {
      _interstitialAdloaded = false;
    });
    UnityMediation.loadInterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      onComplete: (adUnitId) {
        print('Interstitial Ad Load Complete $adUnitId');
        setState(() {
          _interstitialAdloaded = true;
        });
      },
      onFailed: (adUnitId, error, message) =>
          print('Interstitial Ad Load Failed $adUnitId: $error $message'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Unity Mediation Example'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _rewardedAdloaded
                        ? () {
                            UnityMediation.showRewardedAd(
                              adUnitId: AdManager.rewardedAdUnitId,
                              onFailed: (adUnitId, error, message) => print(
                                  'Rewarded Ad $adUnitId failed: $error $message'),
                              onStart: (adUnitId) =>
                                  print('Rewarded Ad $adUnitId started'),
                              onClick: (adUnitId) =>
                                  print('Rewarded Ad $adUnitId click'),
                              onRewarded: (adUnitId, reward) => print(
                                  'Rewarded Ad $adUnitId rewarded $reward'),
                              onClosed: (adUnitId) {
                                print('Rewarded Ad $adUnitId closed');
                                loadRewardedAd();
                              },
                            );
                          }
                        : null,
                    child: const Text('Show Rewarded Ad'),
                  ),
                  ElevatedButton(
                    onPressed: _interstitialAdloaded
                        ? () {
                            UnityMediation.showInterstitialAd(
                              adUnitId: AdManager.interstitialAdUnitId,
                              onFailed: (adUnitId, error, message) => print(
                                  'Interstitial Ad $adUnitId failed: $error $message'),
                              onStart: (adUnitId) =>
                                  print('Interstitial Ad $adUnitId started'),
                              onClick: (adUnitId) =>
                                  print('Interstitial Ad $adUnitId click'),
                              onClosed: (adUnitId) {
                                print('Interstitial Ad $adUnitId closed');
                                loadInterstitialAd();
                              },
                            );
                          }
                        : null,
                    child: const Text('Show Interstitial Ad'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showBanner = !_showBanner;
                      });
                    },
                    child: Text(_showBanner ? 'Hide Banner' : 'Show Banner'),
                  ),
                  if (_showBanner)
                    BannerAd(
                      adUnitId: AdManager.bannerAdUnitId,
                      onLoad: (adUnitId) => print('Banner loaded: $adUnitId'),
                      onClick: (adUnitId) => print('Banner clicked: $adUnitId'),
                      onFailed: (adUnitId, error, message) =>
                          print('Banner Ad $adUnitId failed: $error $message'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdManager {
  static String get gameId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'your_android_game_id';
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'your_ios_game_id';
    }
    return '';
  }

  static String get interstitialAdUnitId {
    return 'unity_mediation_interstitial';
  }

  static String get rewardedAdUnitId {
    return 'unity_mediation_rewarded';
  }

  static String get bannerAdUnitId {
    return 'unity_mediation_banner';
  }
}
