import UnityMediationSdk

class UnityMediationInterstitialAdShowDelegate: NSObject, UMSInterstitialAdShowDelegate {
    var adUnitChannels: [String: FlutterMethodChannel];
    let messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger, adUnitChannels: [String: FlutterMethodChannel]) {
        self.messenger = messenger
        self.adUnitChannels = adUnitChannels
    }
    
    func onInterstitialShowed(_ interstitialAd: UMSInterstitialAd) {
        invokeMethod(UnityMediationConstants.SHOW_START_METHOD, interstitialAd.getUnitId(), arguments: [:])
    }
    
    func onInterstitialClicked(_ interstitialAd: UMSInterstitialAd) {
        invokeMethod(UnityMediationConstants.SHOW_CLICK_METHOD, interstitialAd.getUnitId(), arguments: [:])
    }
    
    func onInterstitialClosed(_ interstitialAd: UMSInterstitialAd) {
        invokeMethod(UnityMediationConstants.SHOW_CLOSED_METHOD, interstitialAd.getUnitId(), arguments: [:])
    }
    
    func onInterstitialFailedShow(_ interstitialAd: UMSInterstitialAd, error: UMSShowError, message: String) {
        var arguments: [String:String] = [:]
        arguments[UnityMediationConstants.ERROR_CODE_PARAMETER]=convertError(error)
        arguments[UnityMediationConstants.ERROR_MESSAGE_PARAMETER]=message
        invokeMethod(UnityMediationConstants.SHOW_FAILED_METHOD, interstitialAd.getUnitId(), arguments: arguments)
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
    
    private func convertError(_ error: UMSShowError) -> String {
        switch (error) {
        case .unknown:
            return "unknown";
        case .adNotLoaded:
            return "notLoaded";
        case .adNetworkError:
            return "networkError";
        @unknown default:
            return ""
        }
    }
}
