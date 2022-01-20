import 'package:flutter/services.dart';

import 'constants.dart';

class UnityMediation {
  static const MethodChannel _channel = MethodChannel(mainChannel);

  static final Map<String, MethodChannel> _channels = {};

  /// Initializes the Unity Mediation.
  /// It is mandatory to call this method before any InterstitialAd and RewardedAd can load.
  ///
  /// * [gameId] - The game ID listed in publisher [dashboard](https://dashboard.unity3d.com).
  /// * [onComplete] - called when initialization has completed successfully.
  /// * [onFailed] - called when initialization has failed.
  static Future<void> init({
    required String gameId,
    Function? onComplete,
    Function(UnityMediationInitializationError error, String errorMessage)?
        onFailed,
  }) async {
    Map<String, dynamic> arguments = {
      gameIdParameter: gameId,
    };
    _channel.setMethodCallHandler(
        (call) => _initMethodCall(call, onComplete, onFailed));
    await _channel.invokeMethod(initMethod, arguments);
  }

  static Future<dynamic> _initMethodCall(
    MethodCall call,
    Function? onComplete,
    Function(UnityMediationInitializationError, String)? onFailed,
  ) {
    switch (call.method) {
      case initCompleteMethod:
        onComplete?.call();
        break;
      case initFailedMethod:
        onFailed?.call(
            _initializationErrorFromString(call.arguments[errorCodeParameter]),
            call.arguments[errorMessageParameter]);
        break;
    }
    return Future.value(true);
  }

  static UnityMediationInitializationError _initializationErrorFromString(
      String error) {
    return UnityMediationInitializationError.values.firstWhere(
        (e) => error == e.toString().split('.').last,
        orElse: () => UnityMediationInitializationError.unknown);
  }

  /// Load a placement to make it available to show. Ads generally take a few seconds to finish loading before they can be shown.
  ///
  /// * [adUnitId] -  The ID of the rewarded ad unit.
  /// * [onComplete] - callback triggered when a load request has successfully filled the specified adUnitId with an ad that is ready to show.
  /// * [onFailed] - called when load request has failed to load an ad for a requested placement.
  static Future<void> loadRewardedAd({
    required String adUnitId,
    Function(String adUnitId)? onComplete,
    Function(String adUnitId, UnityMediationLoadError error,
            String errorMessage)?
        onFailed,
  }) async {
    await _loadAd(
      methodName: loadRewardedAdMethod,
      adUnitId: adUnitId,
      onComplete: onComplete,
      onFailed: onFailed,
    );
  }

  /// Load a placement to make it available to show. Ads generally take a few seconds to finish loading before they can be shown.
  ///
  /// * [adUnitId] -  The ID of the interstitial ad unit.
  /// * [onComplete] - callback triggered when a load request has successfully filled the specified adUnitId with an ad that is ready to show.
  /// * [onFailed] - called when load request has failed to load an ad for a requested placement.
  static Future<void> loadInterstitialAd({
    required String adUnitId,
    Function(String adUnitId)? onComplete,
    Function(String adUnitId, UnityMediationLoadError error,
            String errorMessage)?
        onFailed,
  }) async {
    await _loadAd(
      methodName: loadInterstitialAdMethod,
      adUnitId: adUnitId,
      onComplete: onComplete,
      onFailed: onFailed,
    );
  }

  static Future<void> _loadAd({
    required String methodName,
    required String adUnitId,
    Function(String adUnitId)? onComplete,
    Function(String adUnitId, UnityMediationLoadError error,
            String errorMessage)?
        onFailed,
  }) async {
    _channels
        .putIfAbsent(
            adUnitId, () => MethodChannel('${videoAdChannel}_$adUnitId'))
        .setMethodCallHandler(
            (call) => _loadMethodCall(call, onComplete, onFailed));

    final arguments = <String, dynamic>{
      adUnitIdParameter: adUnitId,
    };
    await _channel.invokeMethod(methodName, arguments);
  }

  static Future<dynamic> _loadMethodCall(
    MethodCall call,
    Function(String adUnitId)? onComplete,
    Function(String adUnitId, UnityMediationLoadError error,
            String errorMessage)?
        onFailed,
  ) {
    switch (call.method) {
      case loadCompleteMethod:
        onComplete?.call(call.arguments[adUnitIdParameter]);
        break;
      case loadFailedMethod:
        onFailed?.call(
          call.arguments[adUnitIdParameter],
          _loadErrorFromString(call.arguments[errorCodeParameter]),
          call.arguments[errorMessageParameter],
        );
        break;
    }
    return Future.value(true);
  }

  static UnityMediationLoadError _loadErrorFromString(String error) {
    return UnityMediationLoadError.values.firstWhere(
        (e) => error == e.toString().split('.').last,
        orElse: () => UnityMediationLoadError.unknown);
  }

  /// Show a rewarded Ad.
  ///
  /// * [adUnitId] - The ID of the rewarded ad unit.
  /// * [onStart] - called on when an ad has started playback.
  /// * [onClick] -  called on when an ad has been clicked by the user.
  /// * [onRewarded] - called on when an ad should reward the user.
  /// * [onClosed] - called on when an ad has closed after playback has completed.
  /// * [onFailed] - called on when an ad has a failure during playback.
  static Future<void> showRewardedAd({
    required String adUnitId,
    Function(String adUnitId)? onStart,
    Function(String adUnitId)? onClick,
    Function(String adUnitId, UnityMediationReward reward)? onRewarded,
    Function(String adUnitId)? onClosed,
    Function(String adUnitId, UnityMediationShowError error,
            String errorMessage)?
        onFailed,
  }) async {
    await _showAd(
      methodName: showRewardedAdMethod,
      adUnitId: adUnitId,
      onStart: onStart,
      onClick: onClick,
      onClosed: onClosed,
      onFailed: onFailed,
      onRewarded: onRewarded,
    );
  }

  /// Show an interstitial Ad
  ///
  /// * [adUnitId] - The ID of the interstitial ad unit.
  /// * [onStart] - called on when an ad has started playback.
  /// * [onClick] -  called on when an ad has been clicked by the user.
  /// * [onClosed] - called on when an ad has closed after playback has completed.
  /// * [onFailed] - called on when an ad has a failure during playback.
  static Future<void> showInterstitialAd({
    required String adUnitId,
    Function(String adUnitId)? onStart,
    Function(String adUnitId)? onClick,
    Function(String adUnitId)? onClosed,
    Function(String adUnitId, UnityMediationShowError error,
            String errorMessage)?
        onFailed,
  }) async {
    await _showAd(
      methodName: showInterstitialAdMethod,
      adUnitId: adUnitId,
      onStart: onStart,
      onClick: onClick,
      onClosed: onClosed,
      onFailed: onFailed,
    );
  }

  static Future<void> _showAd({
    required String methodName,
    required String adUnitId,
    Function(String adUnitId)? onStart,
    Function(String adUnitId)? onClick,
    Function(String adUnitId, UnityMediationReward reward)? onRewarded,
    Function(String adUnitId)? onClosed,
    Function(String adUnitId, UnityMediationShowError error,
            String errorMessage)?
        onFailed,
  }) async {
    _channels
        .putIfAbsent(
            adUnitId, () => MethodChannel('${videoAdChannel}_$adUnitId'))
        .setMethodCallHandler((call) => _showMethodCall(
            call, onStart, onClick, onRewarded, onClosed, onFailed));

    final args = <String, dynamic>{
      adUnitIdParameter: adUnitId,
    };
    await _channel.invokeMethod(methodName, args);
  }

  static Future<dynamic> _showMethodCall(
    MethodCall call,
    Function(String adUnitId)? onStart,
    Function(String adUnitId)? onClick,
    Function(String adUnitId, UnityMediationReward reward)? onRewarded,
    Function(String adUnitId)? onClosed,
    Function(String adUnitId, UnityMediationShowError error,
            String errorMessage)?
        onFailed,
  ) {
    switch (call.method) {
      case showStartMethod:
        onStart?.call(call.arguments[adUnitIdParameter]);
        break;
      case showClosedMethod:
        onClosed?.call(call.arguments[adUnitIdParameter]);
        break;
      case showClickMethod:
        onClick?.call(call.arguments[adUnitIdParameter]);
        break;
      case showRewardedMethod:
        onRewarded?.call(
            call.arguments[adUnitIdParameter],
            UnityMediationReward(
              call.arguments[rewardTypeParameter],
              call.arguments[rewardAmountParameter],
            ));
        break;
      case showFailedMethod:
        onFailed?.call(
          call.arguments[adUnitIdParameter],
          _showErrorFromString(call.arguments[errorCodeParameter]),
          call.arguments[errorMessageParameter],
        );
        break;
    }
    return Future.value(true);
  }

  static UnityMediationShowError _showErrorFromString(String error) {
    return UnityMediationShowError.values.firstWhere(
        (e) => error == e.toString().split('.').last,
        orElse: () => UnityMediationShowError.unknown);
  }
}

class UnityMediationReward {
  final String type;
  final String amount;

  const UnityMediationReward(this.type, this.amount);
}

/// Initialization error states.
enum UnityMediationInitializationError {
  networkError,

  /// Unknown error
  unknown
}

/// Error category of load errors
enum UnityMediationLoadError {
  /// [UnityMediation.init] needs to be called with a valid gameId before loading the ad unit.
  sdkNotInitialized,

  /// The ad unit successfully ran through the waterfall but was unable to get fill from any line items.
  noFill,

  /// A critical HTTP network request has failed.
  networkError,

  /// Unknown error
  unknown
}

/// The error category of show errors
enum UnityMediationShowError {
  notLoaded,

  networkError,

  /// only for android
  invalidActivity,

  /// Unknown error
  unknown
}
