# Unity Mediation

[![Pub](https://img.shields.io/pub/v/unity_mediation.svg)](https://pub.dev/packages/unity_mediation)
[![License](https://img.shields.io/github/license/pavzay/flutter_unity_mediation)](https://github.com/pavzay/flutter_unity_mediation/blob/master/LICENSE)
[![Pub likes](https://badgen.net/pub/likes/unity_mediation)](https://pub.dev/packages/unity_mediation/score)
[![Pub popularity](https://badgen.net/pub/popularity/unity_mediation)](https://pub.dev/packages/unity_mediation/score)
[![Pub points](https://badgen.net/pub/points/unity_mediation)](https://pub.dev/packages/unity_mediation/score)
[![Flutter platform](https://badgen.net/pub/flutter-platform/unity_mediation)](https://pub.dev/packages/unity_mediation)


[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy%20me%20a%20coffee-FFDD00?logo=buymeacoffee)](https://www.buymeacoffee.com/rebeloid)
[![PayPal](https://img.shields.io/badge/Donate-PayPal-066BB7?logo=paypal)](https://paypal.me/pavelzaichyk)

[Unity Mediation](https://docs.unity.com/mediation/IntroToMediation.htm) plugin for Flutter Applications. This plugin is able to display Rewarded and Interstitial Ads from different ad sources.

> If your application uses only ads from Unity Ads source use [Unity Ads Plugin](https://pub.dev/packages/unity_ads_plugin).

- [Getting Started](#getting-started)
    - [1. Configure](#1-configure)
          - [iOS](#ios)
          - [Android](#android)
    - [2. Configure ad sources](#2-configure-ad-sources)
    - [3. Initialization](#3-initialization)
    - [4. Rewarded Ad](#4-rewarded-ad)
    - [5. Interstitial Ad](#5-interstitial-ad)
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

- set `minSdkVersion` to 21 in `android/app/build.gradle` file

### 2. Configure ad sources

For using additional advertising sources, it's needed to configure them.

#### iOS

Add dependencies of configured ad sources to `ios/Podfile` file from the table below

```
target 'Runner' do
  use_frameworks!
  use_modular_headers!
  # list of adapters
  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

AdMob ad source requires additional configuration. If you use AdMob add your AdMob app ID to `ios/Runner/Info.plist` file

```
<key>GADApplicationIdentifier</key>
<string>YOUR_ADMOB_APP_ID</string>
```

#### Android

Add dependencies of configured ad sources to `android/app/build.gradle` file

```
dependencies {
    // list of adapters
}
```

AdMob ad source requires additional configuration. If you use AdMob add your AdMob app ID to `android/app/src/main/AndroidManifest.xml` file

```
<manifest>
    <application>
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="YOUR_ADMOB_APP_ID"/>
    </application>
</manifest>
```

#### Ad Sources

Source | iOS | Android
--- | --- | --- 
[AdColony](https://docs.unity.com/mediation/AdSourceSetupAdColony.htm) | ```pod 'UnityMediationAdColonyAdapter'``` | ```implementation "com.unity3d.mediation:adcolony-adapter:0.3.0"```
[AppLovin](https://docs.unity.com/mediation/AdSourceSetupAppLovin.htm) | ```pod 'UnityMediationAppLovinAdapter'``` | ```implementation "com.unity3d.mediation:applovin-adapter:0.3.0"```
[IronSource](https://docs.unity.com/mediation/AdSourceSetupIronSource.htm) | ```pod 'UnityMediationIronSourceAdapter'``` | ```implementation "com.unity3d.mediation:ironsource-adapter:0.3.0"  ```
[Vungle](https://docs.unity.com/mediation/AdSourceSetupVungle.htm) | ```pod 'UnityMediationVungleAdapter'``` | ```implementation "com.unity3d.mediation:vungle-adapter:0.3.0"```
[Meta Audience Network ](https://docs.unity.com/mediation/AdSourceSetupMetaAudienceNetwork.htm) | ```pod 'UnityMediationFacebookAdapter'``` | ```implementation "com.unity3d.mediation:facebook-adapter:0.3.0"```
[AdMob](https://docs.unity.com/mediation/AdSourceSetupAdMob.htm) | ```pod 'UnityMediationAdmobAdapter'``` | ```implementation "com.unity3d.mediation:admob-adapter:0.3.0"```


### 3. Initialization

Initialize Unity Mediation with your game ID

```dart
UnityMediation.initialize(
  gameId: 'GAME_ID',
  onComplete: () => print('Initialization Complete'),
  onFailed: (error, message) => print('Initialization Failed: $error $message'),
);
```

### 4. Rewarded Ad

![Rewarded Video Ad](https://i.giphy.com/media/3jFdYYJ19T1hXWLG9T/giphy.gif "Rewarded Video Ad")

Load an ad before show it.

```dart
UnityMediation.loadRewardedAd(
  adUnitId: 'REWARDED_AD_UNIT_ID',
  onComplete: (adUnitId) => print('Rewarded Ad Load Complete $adUnitId'),
  onFailed: (adUnitId, error, message) => print('Rewarded Ad Load Failed $adUnitId: $error $message'),
);
```

Show a loaded rewarded ad.

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

### 5. Interstitial Ad

![Interstitial Video Ad](https://i.giphy.com/media/ZR2ZMhinT90z3wVBlY/giphy.gif "Interstitial Video Ad")

Load an ad before show it.

```dart
UnityMediation.loadInterstitialAd(
    adUnitId: 'INTERSTITIAL_AD_UNIT_ID',
    onComplete: (adUnitId) => print('Interstitial Ad Load Complete $adUnitId'),
    onFailed: (adUnitId, error, message) => print('Interstitial Ad Load Failed $adUnitId: $error $message'),
);
```

Show a loaded interstitial ad.

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

