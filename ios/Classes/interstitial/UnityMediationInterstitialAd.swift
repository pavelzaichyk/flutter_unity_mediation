import UnityMediationSdk

class UnityMediationInterstitialAd {
    var adUnitChannels: [String: FlutterMethodChannel]
    var ads: [String: UMSInterstitialAd];
    let loadDelegate: UnityMediationInterstitialAdLoadDelegate;
    let showDelegate: UnityMediationInterstitialAdShowDelegate;
    let viewController : UIViewController;
    
    init(messenger: FlutterBinaryMessenger, viewController : UIViewController) {
        self.adUnitChannels = [String: FlutterMethodChannel]()
        self.ads = [String: UMSInterstitialAd]();
        self.viewController = viewController;
        self.loadDelegate = UnityMediationInterstitialAdLoadDelegate(messenger: messenger, adUnitChannels: adUnitChannels);
        self.showDelegate = UnityMediationInterstitialAdShowDelegate(messenger: messenger, adUnitChannels: adUnitChannels)
    }
    
    public func load(_ args: NSDictionary) -> Bool {
        let ad = getAd(args)
        ad.load(with: loadDelegate)
        return true
    }
    
    public func show(_ args: NSDictionary) -> Bool {
        let ad = getAd(args)
        ad.show(with: viewController, delegate: showDelegate)
        return true
    }
    
    public func getState(_ args: NSDictionary) -> String {
        let ad = getAd(args)
        return StateUtils.convertState(ad.getState())
    }
    
    private func getAd(_ args: NSDictionary) -> UMSInterstitialAd {
        let adUnitId = args[UnityMediationConstants.AD_UNIT_ID_PARAMETER] as! String
        let ad = ads[adUnitId]
        if (ad != nil) {
            return ad!
        }
        
        let newAd = UMSInterstitialAd.init(adUnitId: adUnitId)
        ads[adUnitId] = newAd
        return newAd
    }
    
    
}
