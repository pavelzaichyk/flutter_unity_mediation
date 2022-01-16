# Unity Mediation

[![Pub](https://img.shields.io/pub/v/unity_mediation.svg)](https://pub.dev/packages/unity_mediation)
[![License](https://img.shields.io/github/license/pavzay/flutter_unity_mediation)](https://github.com/pavzay/flutter_unity_mediation/blob/master/LICENSE)
[![Pub likes](https://badgen.net/pub/likes/unity_mediation)](https://pub.dev/packages/unity_mediation/score)
[![Pub popularity](https://badgen.net/pub/popularity/unity_mediation)](https://pub.dev/packages/unity_mediation/score)
[![Pub points](https://badgen.net/pub/points/unity_mediation)](https://pub.dev/packages/unity_mediation/score)
[![Flutter platform](https://badgen.net/pub/flutter-platform/unity_mediation)](https://pub.dev/packages/unity_mediation)


[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy%20me%20a%20coffee-FFDD00?logo=buymeacoffee)](https://www.buymeacoffee.com/rebeloid)
[![PayPal](https://img.shields.io/badge/Donate-PayPal-066BB7?logo=paypal)](https://paypal.me/pavelzaichyk)

[Unity Mediation](https://docs.unity.com/mediation/IntroToMediation.htm) plugin for Flutter Applications. This plugin is able to display Rewarded and Interstitial Ads.

- [Getting Started](#getting-started)
    - [1. Configure](#1-configure)
      - [iOS](#ios)
      - [Android](#android)
    - [2. Initialization](#2-initialization)
    - [3. Rewarded Ad](#3-rewarded-ad)
    - [4. Interstitial Ad](#4-interstitial-ad)
- [Donate](#donate)

## Getting Started

### 1. Configure

#### iOS

- set iOS version to 9.0 or higher in `ios/Podfile` file
- in `ios/Podfile` file add next lines after `platform :ios` line:

```
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Unity-Technologies/unity-mediation-cocoapods-prod.git'
```

#### Android

### 2. Initialization

```dart
UnityMediation.init(
  gameId: 'GAME_ID',
  onComplete: () => print('Initialization Complete'),
  onFailed: (error, message) => print('Initialization Failed: $error $message'),
);
```

Set your Game ID.

### 3. Rewarded Ad

![Rewarded Video Ad](https://github.com/pavzay/flutter_unity_ads/raw/master/example/images/rewarded.gif "Rewarded Video Ad")

Load an ad before show it.

```dart
UnityMediation.loadRewardedAd(
  adUnitId: 'REWARDED_AD_UNIT_ID',
  onComplete: (adUnitId) => print('Rewarded Ad Load Complete $adUnitId'),
  onFailed: (adUnitId, error, message) => print('Rewarded Ad Load Failed $adUnitId: $error $message'),
);
```

```dart
UnityMediation.showRewardedAd(
  adUnitId: 'REWARDED_AD_UNIT_ID',
  onStart: (adUnitId) => print('Rewarded Ad $adUnitId started'),
  onClick: (adUnitId) => print('Rewarded Ad $adUnitId click'),
  onRewarded: (adUnitId, reward) => print('Rewarded Ad $adUnitId rewarded $reward'),
  onClosed: (adUnitId) => print('Rewarded Ad $adUnitId closed'),
  onFailed: (adUnitId, error, message) => print('Rewarded Ad $adUnitId failed: $error $message'),
);
```

### 4. Interstitial Ad

![Interstitial Video Ad](https://github.com/pavzay/flutter_unity_ads/raw/master/example/images/interstitial.gif "Interstitial Video Ad")

Load an ad before show it.

```dart
UnityMediation.loadInterstitialAd(
    adUnitId: 'INTERSTITIAL_AD_UNIT_ID',
    onComplete: (adUnitId) => print('Interstitial Ad Load Complete $adUnitId'),
    onFailed: (adUnitId, error, message) => print('Interstitial Ad Load Failed $adUnitId: $error $message'),
);
```

```dart
UnityMediation.showInterstitialAd(
    adUnitId: 'INTERSTITIAL_AD_UNIT_ID',
    onStart: (adUnitId) => print('Interstitial Ad $adUnitId started'),
    onClick: (adUnitId) => print('Interstitial Ad $adUnitId click'),
    onClosed: (adUnitId) => print('Interstitial Ad $adUnitId closed'),
    onFailed: (adUnitId, error, message) => print('Interstitial Ad $adUnitId failed: $error $message'),
);
```

## Donate

If you found this plugin helpful and would like to thank me:

[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy%20me%20a%20coffee-FFDD00?logo=buymeacoffee)](https://www.buymeacoffee.com/rebeloid)
[![PayPal](https://img.shields.io/badge/Donate-PayPal-066BB7?logo=paypal)](https://paypal.me/pavelzaichyk)


# Possible errors

android/app/build.gradle

minSdkVersion = 18