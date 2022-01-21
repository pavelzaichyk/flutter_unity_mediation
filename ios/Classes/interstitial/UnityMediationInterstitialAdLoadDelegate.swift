import UnityMediationSdk

class UnityMediationInterstitialAdLoadDelegate  : AdMethodChannelCaller, UMSInterstitialAdLoadDelegate{

    func onInterstitialLoaded(_ interstitialAd: UMSInterstitialAd) {
        invokeMethod(UnityMediationConstants.LOAD_COMPLETE_METHOD, interstitialAd.getUnitId())
    }

    func onInterstitialFailedLoad(_ interstitialAd: UMSInterstitialAd, error: UMSLoadError, message: String) {
        invokeMethod(UnityMediationConstants.LOAD_FAILED_METHOD, interstitialAd.getUnitId(), errorCode: ErrorUtils.convertError(error), errorMessage: message)
    }

}
