import Flutter
import UnityMediationSdk

public class SwiftUnityMediationPlugin: NSObject, FlutterPlugin {
    
    public  static  func register(with registrar: FlutterPluginRegistrar) {
        let viewController = (UIApplication.shared.delegate?.window??.rootViewController)!;
        let binaryMessenger = registrar.messenger();
        let mainChannel = FlutterMethodChannel(name: UnityMediationConstants.MAIN_CHANNEL, binaryMessenger: binaryMessenger)
        
        let initialization = UnityMediationInitialization(channel: mainChannel)
        
        let adUnitChannels = [String: FlutterMethodChannel]()
        let rewardedAd = UnityMediationRewardedAd(messenger: binaryMessenger, adUnitChannels: adUnitChannels, viewController: viewController)
        let interstitialAd = UnityMediationInterstitialAd(messenger: binaryMessenger, adUnitChannels: adUnitChannels, viewController: viewController)
        
        mainChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            let args = call.arguments as! NSDictionary
            switch call.method {
            case UnityMediationConstants.INIT_METHOD:
                result(initialization.initialize(args))
            case UnityMediationConstants.LOAD_REWARDED_AD_METHOD:
                result(rewardedAd.load(args))
            case UnityMediationConstants.SHOW_REWARDED_AD_METHOD:
                result(rewardedAd.show(args))
            case UnityMediationConstants.LOAD_INTERSTITIAL_AD_METHOD:
                result(interstitialAd.load(args))
            case UnityMediationConstants.SHOW_INTERSTITIAL_AD_METHOD:
                result(interstitialAd.show(args))
            default:
                result(FlutterMethodNotImplemented)
            }
        })
    }
}
