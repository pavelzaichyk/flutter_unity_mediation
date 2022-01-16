import UnityMediationSdk

class UnityMediationInterstitialAdLoadDelegate  : NSObject, UMSInterstitialAdLoadDelegate{
    var adUnitChannels: [String: FlutterMethodChannel];
    let messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger, adUnitChannels: [String: FlutterMethodChannel]) {
        self.messenger = messenger
        self.adUnitChannels = adUnitChannels
    }
    
    func onInterstitialLoaded(_ interstitialAd: UMSInterstitialAd) {
        invokeMethod(UnityMediationConstants.LOAD_COMPLETE_METHOD, interstitialAd.getUnitId(), arguments: [:])
    }
    
    func onInterstitialFailedLoad(_ interstitialAd: UMSInterstitialAd, error: UMSLoadError, message: String) {
        var arguments: [String:String] = [:]
        arguments[UnityMediationConstants.ERROR_CODE_PARAMETER]=convertError(error)
        arguments[UnityMediationConstants.ERROR_MESSAGE_PARAMETER]=message
        invokeMethod(UnityMediationConstants.LOAD_FAILED_METHOD, interstitialAd.getUnitId(), arguments: arguments)
    }
    
    func invokeMethod(_ methodName: String,_ adUnitId: String, arguments: [String:String]){
        var args = arguments;
        args[UnityMediationConstants.AD_UNIT_ID_PARAMETER]=adUnitId
        var channel = adUnitChannels[adUnitId]
        if (channel == nil) {
            channel = FlutterMethodChannel(name: UnityMediationConstants.VIDEO_AD_CHANNEL + "_" + adUnitId, binaryMessenger: messenger)
            adUnitChannels[adUnitId] = channel
        }
        channel?.invokeMethod(methodName, arguments: args)
    }
    
    private func convertError(_ error: UMSLoadError) -> String {
        switch (error) {
        case .unknown:
            return "unknown";
        case .none:
            return ""
        case .noFill:
            return "noFill";
        case .networkError:
            return "networkError";
        case .sdkNotInitialized:
            return "sdkNotInitialized";
        @unknown default:
            return ""
        }
    }
}
