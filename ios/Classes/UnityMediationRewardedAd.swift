import UnityMediationSdk

class UnityMediationRewardedAd {
    var rewardedAds: [String: UMSRewardedAd];
    let loadDelegate: UnityMediationRewardedAdLoadDelegate;
    let showDelegate: UnityMediationRewardedAdShowDelegate;
    let viewController : UIViewController;
    
    init(messenger: FlutterBinaryMessenger, adUnitChannels: [String: FlutterMethodChannel], viewController : UIViewController) {
        self.rewardedAds = [String: UMSRewardedAd]();
        self.viewController = viewController;
        self.loadDelegate = UnityMediationRewardedAdLoadDelegate(messenger: messenger, adUnitChannels: adUnitChannels);
        self.showDelegate = UnityMediationRewardedAdShowDelegate(messenger: messenger, adUnitChannels: adUnitChannels)
    }
    
    public func load(_ args: NSDictionary) -> Bool {
        let adUnitId = args[UnityMediationConstants.AD_UNIT_ID_PARAMETER] as! String
        let rewardedAd = getRewardedAd(adUnitId)
        rewardedAd.load(with: loadDelegate)
        return true
    }
    
    public func show(_ args: NSDictionary) -> Bool {
        let adUnitId = args[UnityMediationConstants.AD_UNIT_ID_PARAMETER] as! String
        let rewardedAd = getRewardedAd(adUnitId)
        rewardedAd.show(with: viewController, delegate: showDelegate)
        return true
    }
    
    private func getRewardedAd(_ adUnitId: String) -> UMSRewardedAd {
        let rewardedAd = rewardedAds[adUnitId]
        if (rewardedAd != nil) {
            return rewardedAd!
        }
        
        let ad = UMSRewardedAd.init(adUnitId: adUnitId)
        rewardedAds[adUnitId] = ad
        return ad
    }
}
