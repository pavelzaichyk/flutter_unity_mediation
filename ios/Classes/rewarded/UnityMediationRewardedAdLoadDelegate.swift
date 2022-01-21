import UnityMediationSdk

class UnityMediationRewardedAdLoadDelegate : AdMethodChannelCaller, UMSRewardedAdLoadDelegate{
    
    func onRewardedLoaded(_ rewardedAd: UMSRewardedAd) {
        invokeMethod(UnityMediationConstants.LOAD_COMPLETE_METHOD, rewardedAd.getUnitId())
    }
    
    func onRewardedFailedLoad(_ rewardedAd: UMSRewardedAd, error: UMSLoadError, message: String) {
        invokeMethod(UnityMediationConstants.LOAD_FAILED_METHOD, rewardedAd.getUnitId(),errorCode: ErrorUtils.convertError(error), errorMessage: message)
    }
    
}
