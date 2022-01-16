import UnityMediationSdk

class UnityMediationInterstitialAd {
    var ads: [String: UMSInterstitialAd];
    let loadDelegate: UnityMediationInterstitialAdLoadDelegate;
    let showDelegate: UnityMediationInterstitialAdShowDelegate;
    let viewController : UIViewController;
    
    init(messenger: FlutterBinaryMessenger, adUnitChannels: [String: FlutterMethodChannel], viewController : UIViewController) {
        self.ads = [String: UMSInterstitialAd]();
        self.viewController = viewController;
        self.loadDelegate = UnityMediationInterstitialAdLoadDelegate(messenger: messenger, adUnitChannels: adUnitChannels);
        self.showDelegate = UnityMediationInterstitialAdShowDelegate(messenger: messenger, adUnitChannels: adUnitChannels)
    }
    
    public func load(_ args: NSDictionary) -> Bool {
        let adUnitId = args[UnityMediationConstants.AD_UNIT_ID_PARAMETER] as! String
        let ad = getAd(adUnitId)
        ad.load(with: loadDelegate)
        return true
    }
    
    public func show(_ args: NSDictionary) -> Bool {
        let adUnitId = args[UnityMediationConstants.AD_UNIT_ID_PARAMETER] as! String
        let ad = getAd(adUnitId)
        ad.show(with: viewController, delegate: showDelegate)
        return true
    }
    
    private func getAd(_ adUnitId: String) -> UMSInterstitialAd {
        let ad = ads[adUnitId]
        if (ad != nil) {
            return ad!
        }
        
        let newAd = UMSInterstitialAd.init(adUnitId: adUnitId)
        ads[adUnitId] = newAd
        return newAd
    }
}
