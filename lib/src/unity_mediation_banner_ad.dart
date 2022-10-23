import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'constants.dart';
import 'unity_mediation.dart';

class BannerAd extends StatefulWidget {
  /// The ID of the banner ad.
  final String adUnitId;

  /// Size of the banner ad.
  final BannerSize size;

  /// Called when the banner is loaded and ready to be placed in the view hierarchy.
  final void Function(String adUnitId)? onLoad;

  /// Called when the user clicks the banner.
  final void Function(String adUnitId)? onClick;

  /// Called when unity ads banner encounters an error.
  final void Function(String adUnitId, LoadError error, String errorMessage)? onFailed;

  /// This widget is used to contain Banner Ads.
  const BannerAd({
    Key? key,
    required this.adUnitId,
    this.size = BannerSize.standard,
    this.onLoad,
    this.onClick,
    this.onFailed,
  }) : super(key: key);

  @override
  BannerAdState createState() => BannerAdState();
}

class BannerAdState extends State<BannerAd> {
  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return SizedBox(
        height: widget.size.height + 0.0,
        width: widget.size.width + 0.0,
        child: OverflowBox(
          maxHeight: _isLoaded ? widget.size.height + 0.0 : 1,
          minHeight: 0.1,
          alignment: Alignment.bottomCenter,
          child: AndroidView(
            viewType: bannerAdChannel,
            creationParams: <String, dynamic>{
              adUnitIdParameter: widget.adUnitId,
              bannerWidthParameter: widget.size.width,
              bannerHeightParameter: widget.size.height,
            },
            creationParamsCodec: const StandardMessageCodec(),
            onPlatformViewCreated: _onBannerAdViewCreated,
          ),
        ),
      );
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return SizedBox(
        height: widget.size.height + 0.0,
        width: widget.size.width + 0.0,
        child: OverflowBox(
          maxHeight: _isLoaded ? widget.size.height + 0.0 : 1,
          minHeight: 0.1,
          alignment: Alignment.bottomCenter,
          child: UiKitView(
            viewType: bannerAdChannel,
            creationParams: <String, dynamic>{
              adUnitIdParameter: widget.adUnitId,
              bannerWidthParameter: widget.size.width,
              bannerHeightParameter: widget.size.height,
            },
            creationParamsCodec: const StandardMessageCodec(),
            onPlatformViewCreated: _onBannerAdViewCreated,
          ),
        ),
      );
    }

    return Container();
  }

  void _onBannerAdViewCreated(int id) {
    final channel = MethodChannel('${bannerAdChannel}_$id');

    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case bannerErrorMethod:
          widget.onFailed?.call(
            call.arguments[adUnitIdParameter],
            _loadErrorFromString(call.arguments[errorCodeParameter]),
            call.arguments[errorMessageParameter],
          );
          break;
        case bannerLoadedMethod:
          setState(() {
            _isLoaded = true;
          });
          widget.onLoad?.call(call.arguments[adUnitIdParameter]);
          break;
        case bannerClickedMethod:
          widget.onClick?.call(call.arguments[adUnitIdParameter]);
          break;
      }
    });
  }

  LoadError _loadErrorFromString(String error) {
    return LoadError.values
        .firstWhere((e) => error == e.toString().split('.').last, orElse: () => LoadError.unknown);
  }
}

/// Defines the size of Banner Ad.
class BannerSize {
  final int width;
  final int height;

  static const BannerSize standard = BannerSize(width: 320, height: 50);
  static const BannerSize large = BannerSize(width: 320, height: 100);
  static const BannerSize leaderboard = BannerSize(width: 728, height: 90);
  static const BannerSize mediumRectangle = BannerSize(width: 300, height: 250);

  const BannerSize({this.width = 320, this.height = 50});
}
