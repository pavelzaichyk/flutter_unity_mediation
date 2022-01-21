import UnityMediationSdk

class UnityMediationInterstitialAdShowDelegate: AdMethodChannelCaller, UMSInterstitialAdShowDelegate {
    
    func onInterstitialShowed(_ interstitialAd: UMSInterstitialAd) {
        invokeMethod(UnityMediationConstants.SHOW_START_METHOD, interstitialAd.getUnitId())
    }
    
    func onInterstitialClicked(_ interstitialAd: UMSInterstitialAd) {
        invokeMethod(UnityMediationConstants.SHOW_CLICK_METHOD, interstitialAd.getUnitId())
    }
    
    func onInterstitialClosed(_ interstitialAd: UMSInterstitialAd) {
        invokeMethod(UnityMediationConstants.SHOW_CLOSED_METHOD, interstitialAd.getUnitId())
    }
    
    func onInterstitialFailedShow(_ interstitialAd: UMSInterstitialAd, error: UMSShowError, message: String) {
        invokeMethod(UnityMediationConstants.SHOW_FAILED_METHOD, interstitialAd.getUnitId(), errorCode:ErrorUtils.convertError(error), errorMessage: message)
    }
    
}
