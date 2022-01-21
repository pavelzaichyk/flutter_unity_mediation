import UnityMediationSdk

class UnityMediationRewardedAd {
    var adUnitChannels: [String: FlutterMethodChannel]
    var rewardedAds: [String: UMSRewardedAd];
    let loadDelegate: UnityMediationRewardedAdLoadDelegate;
    let showDelegate: UnityMediationRewardedAdShowDelegate;
    let viewController : UIViewController;
    
    init(messenger: FlutterBinaryMessenger, viewController : UIViewController) {
        self.adUnitChannels = [String: FlutterMethodChannel]()
        self.rewardedAds = [String: UMSRewardedAd]();
        self.viewController = viewController;
        self.loadDelegate = UnityMediationRewardedAdLoadDelegate(messenger: messenger, adUnitChannels: adUnitChannels);
        self.showDelegate = UnityMediationRewardedAdShowDelegate(messenger: messenger, adUnitChannels: adUnitChannels)
    }
    
    public func load(_ args: NSDictionary) -> Bool {
        let rewardedAd = getAd(args)
        rewardedAd.load(with: loadDelegate)
        return true
    }
    
    public func show(_ args: NSDictionary) -> Bool {
        let rewardedAd = getAd(args)
        rewardedAd.show(with: viewController, delegate: showDelegate)
        return true
    }
    
    public func getState(_ args: NSDictionary) -> String {
        let ad = getAd(args)
        return StateUtils.convertState(ad.getState())
    }
    
    private func getAd(_ args: NSDictionary) -> UMSRewardedAd {
        let adUnitId = args[UnityMediationConstants.AD_UNIT_ID_PARAMETER] as! String
        let rewardedAd = rewardedAds[adUnitId]
        if (rewardedAd != nil) {
            return rewardedAd!
        }
        
        let ad = UMSRewardedAd.init(adUnitId: adUnitId)
        rewardedAds[adUnitId] = ad
        return ad
    }
}
