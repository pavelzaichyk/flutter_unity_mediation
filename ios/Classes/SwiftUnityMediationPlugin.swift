import Flutter
import UnityMediationSdk

public class SwiftUnityMediationPlugin: NSObject, FlutterPlugin {
    
    public  static  func register(with registrar: FlutterPluginRegistrar) {
        let viewController = (UIApplication.shared.delegate?.window??.rootViewController)!;
        let binaryMessenger = registrar.messenger();
        let mainChannel = FlutterMethodChannel(name: UnityMediationConstants.MAIN_CHANNEL, binaryMessenger: binaryMessenger)
        
        let initialization = UnityMediationInitialization(channel: mainChannel)
        let rewardedAd = UnityMediationRewardedAd(messenger: binaryMessenger, viewController: viewController)
        let interstitialAd = UnityMediationInterstitialAd(messenger: binaryMessenger, viewController: viewController)
        
        mainChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            let args = call.arguments as! NSDictionary
            switch call.method {
            case UnityMediationConstants.INIT_METHOD:
                result(initialization.initialize(args))
            case UnityMediationConstants.INIT_STATE_METHOD:
                result(initialization.getInitializationState())
            case UnityMediationConstants.LOAD_REWARDED_AD_METHOD:
                result(rewardedAd.load(args))
            case UnityMediationConstants.SHOW_REWARDED_AD_METHOD:
                result(rewardedAd.show(args))
            case UnityMediationConstants.LOAD_INTERSTITIAL_AD_METHOD:
                result(interstitialAd.load(args))
            case UnityMediationConstants.SHOW_INTERSTITIAL_AD_METHOD:
                result(interstitialAd.show(args))
            case UnityMediationConstants.REWARDED_AD_STATE_METHOD:
                result(rewardedAd.getState(args))
            case UnityMediationConstants.INTERSTITIAL_AD_STATE_METHOD:
                result(interstitialAd.getState(args))
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        
        registrar.register(
            BannerAdFactory(messenger: binaryMessenger, viewController: viewController),
            withId: UnityMediationConstants.BANNER_AD_CHANNEL
        )
    }
}
