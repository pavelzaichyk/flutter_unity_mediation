import UnityMediationSdk

class UnityMediationRewardedAdShowDelegate: NSObject, UMSRewardedAdShowDelegate {
    var adUnitChannels: [String: FlutterMethodChannel];
    let messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger, adUnitChannels: [String: FlutterMethodChannel]) {
        self.messenger = messenger
        self.adUnitChannels = adUnitChannels
    }
    
    func onRewardedShowed(_ rewardedAd: UMSRewardedAd) {
        invokeMethod(UnityMediationConstants.SHOW_START_METHOD, rewardedAd.getUnitId(), arguments: [:])
    }
    
    func onRewardedClicked(_ rewardedAd: UMSRewardedAd) {
        invokeMethod(UnityMediationConstants.SHOW_CLICK_METHOD, rewardedAd.getUnitId(), arguments: [:])
    }
    
    func onRewardedClosed(_ rewardedAd: UMSRewardedAd) {
        invokeMethod(UnityMediationConstants.SHOW_CLOSED_METHOD, rewardedAd.getUnitId(), arguments: [:])
    }
    
    func onRewardedFailedShow(_ rewardedAd: UMSRewardedAd, error: UMSShowError, message: String) {
        var arguments: [String:String] = [:]
        arguments[UnityMediationConstants.ERROR_CODE_PARAMETER]=convertError(error)
        arguments[UnityMediationConstants.ERROR_MESSAGE_PARAMETER]=message
        invokeMethod(UnityMediationConstants.SHOW_FAILED_METHOD, rewardedAd.getUnitId(), arguments: arguments)
    }
    
    func onUserRewarded(_ rewardedAd: UMSRewardedAd, reward: UMSReward) {
        invokeMethod(UnityMediationConstants.SHOW_REWARDED_METHOD, rewardedAd.getUnitId(), arguments: [
            UnityMediationConstants.REWARD_TYPE_PARAMETER:reward.getType(),
            UnityMediationConstants.REWARD_AMOUNT_PARAMETER:reward.getAmount()
        ])
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
