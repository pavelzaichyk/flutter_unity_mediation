import UnityMediationSdk

class UnityMediationRewardedAdShowDelegate: AdMethodChannelCaller, UMSRewardedAdShowDelegate {
    
    func onRewardedShowed(_ rewardedAd: UMSRewardedAd) {
        invokeMethod(UnityMediationConstants.SHOW_START_METHOD, rewardedAd.getUnitId())
    }
    
    func onRewardedClicked(_ rewardedAd: UMSRewardedAd) {
        invokeMethod(UnityMediationConstants.SHOW_CLICK_METHOD, rewardedAd.getUnitId())
    }
    
    func onRewardedClosed(_ rewardedAd: UMSRewardedAd) {
        invokeMethod(UnityMediationConstants.SHOW_CLOSED_METHOD, rewardedAd.getUnitId())
    }
    
    func onRewardedFailedShow(_ rewardedAd: UMSRewardedAd, error: UMSShowError, message: String) {
        invokeMethod(UnityMediationConstants.SHOW_FAILED_METHOD, rewardedAd.getUnitId(), errorCode: ErrorUtils.convertError(error), errorMessage: message)
    }
    
    func onUserRewarded(_ rewardedAd: UMSRewardedAd, reward: UMSReward) {
        invokeMethod(UnityMediationConstants.SHOW_REWARDED_METHOD, rewardedAd.getUnitId(), arguments: [
            UnityMediationConstants.REWARD_TYPE_PARAMETER:reward.getType(),
            UnityMediationConstants.REWARD_AMOUNT_PARAMETER:reward.getAmount()
        ])
    }
}
