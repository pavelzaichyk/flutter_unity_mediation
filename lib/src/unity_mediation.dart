import 'package:flutter/services.dart';

import 'constants.dart';

class UnityMediation {
  static const MethodChannel _channel = MethodChannel(mainChannel);

  static final Map<String, _AdMethodChannel> _adChannels = {};

  /// Initializes the Unity Mediation.
  /// It is mandatory to call this method before any InterstitialAd and RewardedAd can load.
  ///
  /// * [gameId] - The game ID listed in publisher [dashboard](https://dashboard.unity3d.com).
  /// * [onComplete] - called when initialization has completed successfully.
  /// * [onFailed] - called when initialization has failed.
  static Future<void> initialize({
    required String gameId,
    Function? onComplete,
    Function(InitializationError error, String errorMessage)? onFailed,
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
    Function(InitializationError, String)? onFailed,
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

  static InitializationError _initializationErrorFromString(String error) {
    return InitializationError.values.firstWhere(
        (e) => error == e.toString().split('.').last,
        orElse: () => InitializationError.unknown);
  }

  /// This method returns the current initialization state of the Unity Mediation service at runtime.
  static Future<InitializationState> getInitializationState() async {
    final String state = await _channel.invokeMethod(initStateMethod, {});
    return _initializationStateFromString(state);
  }

  static InitializationState _initializationStateFromString(String state) {
    return InitializationState.values.firstWhere(
        (e) => state == e.toString().split('.').last,
        orElse: () => InitializationState.uninitialized);
  }

  /// Load a placement to make it available to show. Ads generally take a few seconds to finish loading before they can be shown.
  ///
  /// * [adUnitId] -  The ID of the rewarded ad unit.
  /// * [onComplete] - callback triggered when a load request has successfully filled the specified adUnitId with an ad that is ready to show.
  /// * [onFailed] - called when load request has failed to load an ad for a requested placement.
  static Future<void> loadRewardedAd({
    required String adUnitId,
    Function(String adUnitId)? onComplete,
    Function(String adUnitId, LoadError error, String errorMessage)? onFailed,
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
    Function(String adUnitId, LoadError error, String errorMessage)? onFailed,
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
    Function(String adUnitId, LoadError error, String errorMessage)? onFailed,
  }) async {
    _adChannels.putIfAbsent(adUnitId, () => _AdMethodChannel(adUnitId)).update(
          onLoadComplete: onComplete,
          onLoadFailed: onFailed,
        );

    final arguments = <String, dynamic>{
      adUnitIdParameter: adUnitId,
    };
    await _channel.invokeMethod(methodName, arguments);
  }

  /// Show a rewarded Ad.
  ///
  /// * [adUnitId] - The ID of the rewarded ad unit.
  /// * [onStart] - called on when an ad has started playback.
  /// * [onClick] -  called on when an ad has been clicked by the user.
  /// * [onRewarded] - called on when an ad should reward the user.
  /// * [onClosed] - called on when an ad has closed after playback has completed.
  /// * [onFailed] - called on when an ad has a failure during playback.
  /// Server-to-server redeem callbacks: https://docs.unity.com/mediation/S2SRedeemCallbacks.html
  /// * [userId] - The publisher's user id. This will be passed along in the S2S reward callback feature to the publisher's S2S server.
  /// * [customizedData] - The publisher's custom data in whatever string format they wish (ex. JSON). This can be any data that the publisher wants forwarded to their S2S server.
  static Future<void> showRewardedAd({
    required String adUnitId,
    Function(String adUnitId)? onStart,
    Function(String adUnitId)? onClick,
    Function(String adUnitId, UnityMediationReward reward)? onRewarded,
    Function(String adUnitId)? onClosed,
    Function(String adUnitId, ShowError error, String errorMessage)? onFailed,
    String? userId,
    String? customizedData,
  }) async {
    await _showAd(
      methodName: showRewardedAdMethod,
      adUnitId: adUnitId,
      onStart: onStart,
      onClick: onClick,
      onClosed: onClosed,
      onFailed: onFailed,
      onRewarded: onRewarded,
      userId: userId,
      customizedData: customizedData,
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
    Function(String adUnitId, ShowError error, String errorMessage)? onFailed,
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
    Function(String adUnitId, ShowError error, String errorMessage)? onFailed,
    String? userId,
    String? customizedData,
  }) async {
    _adChannels.putIfAbsent(adUnitId, () => _AdMethodChannel(adUnitId)).update(
          onAdStart: onStart,
          onAdClick: onClick,
          onAdClosed: onClosed,
          onShowFailed: onFailed,
          onAdRewarded: onRewarded,
        );
    print('USER_ID $userId');
    final args = <String, dynamic>{
      adUnitIdParameter: adUnitId,
      stsUserIdParameter: userId,
      stsCustomizedDataParameter: customizedData,
    };
    await _channel.invokeMethod(methodName, args);
  }

  /// This method returns the current [AdState] of the requested ad.
  /// * [adUnitId] - The ID of the rewarded ad unit.
  static Future<AdState> getRewardedAdState(String adUnitId) async {
    final String state = await _channel.invokeMethod(
      rewardedAdStateMethod,
      {adUnitIdParameter: adUnitId},
    );
    return _adStateFromString(state);
  }

  /// This method returns the current [AdState] of the interstitial ad.
  /// * [adUnitId] - The ID of the interstitial ad unit.
  static Future<AdState> getInterstitialAdState(String adUnitId) async {
    final String state = await _channel.invokeMethod(
      interstitialAdStateMethod,
      {adUnitIdParameter: adUnitId},
    );
    return _adStateFromString(state);
  }

  static AdState _adStateFromString(String state) {
    return AdState.values.firstWhere(
        (e) => state == e.toString().split('.').last,
        orElse: () => AdState.unloaded);
  }
}

class UnityMediationReward {
  final String type;
  final String amount;

  const UnityMediationReward(this.type, this.amount);
}

/// Initialization states of the Mediation SDK.
enum InitializationState {
  /// The Mediation SDK is not initialized.
  uninitialized,

  /// The Mediation SDK is in the process of initializing.
  initializing,

  /// The Mediation SDK is properly initialized.
  initialized,
}

/// Initialization error states.
enum InitializationError {
  networkError,

  /// An unknown error occurred.
  unknown
}

/// Errors that can cause an ad not to load.
enum LoadError {
  /// [UnityMediation.initialize] needs to be called with a valid gameId before loading the ad unit.
  sdkNotInitialized,

  /// The ad unit successfully ran through the waterfall but was unable to get fill from any line items.
  noFill,

  /// A critical HTTP network request has failed.
  networkError,

  /// An unknown error occurred.
  unknown
}

/// Errors that can cause an ad not to show.
enum ShowError {
  /// The ad is loaded, but not available to show. In this case, the Ad Unit will reset to unloaded in order to attempt to load again.
  notLoaded,

  /// An issue occurred with the ad network attempting to show the ad. In this case, be sure to check for potential problems such as invalid ad network values, cache issues, or video player issues, pertaining to the ad network. Unity Mediation will supply the original message and error code from the problematic ad network.
  networkError,

  /// only for android
  invalidActivity,

  /// An unknown error occurred.
  unknown
}

/// States of a requested ad.
enum AdState {
  /// Indicates that an Ad Unit is ready to load. Ad Units that are unloaded cannot show ads. This state occurs when an ad is instanced, failed to load, failed to show, or is closed.
  unloaded,

  /// Indicates that an Ad Unit is in the process of loading ad content. Ad Units that are loading cannot be loaded again until the in-process load fails, or after the loaded ad shows (or fails to show). This state occurs when an Ad Unit requests an ad.
  loading,

  /// Indicates that an Ad Unit has loaded content that is ready to show. Ad Units that are loaded cannot be loaded again until the content shows (or fails to show). This state occurs when an ad load request succeeds.
  loaded,

  /// Indicates that an Ad Unit is in the process of showing loaded content. Ad Units that are showing cannot be loaded or shown again until playback completes (or fails). This state occurs when Show is called.
  showing,
}

class _AdMethodChannel {
  final MethodChannel channel;
  Function(String adUnitId)? onLoadComplete;
  Function(String adUnitId, LoadError error, String errorMessage)? onLoadFailed;
  Function(String adUnitId)? onAdStart;
  Function(String adUnitId)? onAdClick;
  Function(String adUnitId, UnityMediationReward reward)? onAdRewarded;
  Function(String adUnitId)? onAdClosed;
  Function(String adUnitId, ShowError error, String errorMessage)? onShowFailed;

  _AdMethodChannel(String adUnitId)
      : channel = MethodChannel('${videoAdChannel}_$adUnitId') {
    channel.setMethodCallHandler(_methodCallHandler);
  }

  void update({
    Function(String adUnitId)? onLoadComplete,
    Function(String adUnitId, LoadError error, String errorMessage)?
        onLoadFailed,
    Function(String adUnitId)? onAdStart,
    Function(String adUnitId)? onAdClick,
    Function(String adUnitId, UnityMediationReward reward)? onAdRewarded,
    Function(String adUnitId)? onAdClosed,
    Function(String adUnitId, ShowError error, String errorMessage)?
        onShowFailed,
  }) {
    this.onLoadComplete = onLoadComplete ?? this.onLoadComplete;
    this.onLoadFailed = onLoadFailed ?? this.onLoadFailed;
    this.onAdStart = onAdStart ?? this.onAdStart;
    this.onAdClick = onAdClick ?? this.onAdClick;
    this.onAdRewarded = onAdRewarded ?? this.onAdRewarded;
    this.onAdClosed = onAdClosed ?? this.onAdClosed;
    this.onShowFailed = onShowFailed ?? this.onShowFailed;
  }

  Future _methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case loadCompleteMethod:
        onLoadComplete?.call(call.arguments[adUnitIdParameter]);
        break;
      case loadFailedMethod:
        onLoadFailed?.call(
          call.arguments[adUnitIdParameter],
          _loadErrorFromString(call.arguments[errorCodeParameter]),
          call.arguments[errorMessageParameter],
        );
        break;
      case showStartMethod:
        onAdStart?.call(call.arguments[adUnitIdParameter]);
        break;
      case showClosedMethod:
        onAdClosed?.call(call.arguments[adUnitIdParameter]);
        break;
      case showClickMethod:
        onAdClick?.call(call.arguments[adUnitIdParameter]);
        break;
      case showRewardedMethod:
        onAdRewarded?.call(
            call.arguments[adUnitIdParameter],
            UnityMediationReward(
              call.arguments[rewardTypeParameter],
              call.arguments[rewardAmountParameter],
            ));
        break;
      case showFailedMethod:
        onShowFailed?.call(
          call.arguments[adUnitIdParameter],
          _showErrorFromString(call.arguments[errorCodeParameter]),
          call.arguments[errorMessageParameter],
        );
        break;
    }
  }

  LoadError _loadErrorFromString(String error) {
    return LoadError.values.firstWhere(
        (e) => error == e.toString().split('.').last,
        orElse: () => LoadError.unknown);
  }

  ShowError _showErrorFromString(String error) {
    return ShowError.values.firstWhere(
        (e) => error == e.toString().split('.').last,
        orElse: () => ShowError.unknown);
  }
}
