import Flutter
import UnityMediationSdk

class BannerView: NSObject, FlutterPlatformView, UMSBannerAdViewDelegate {
    private let uiView : UIView
    private let channel: FlutterMethodChannel
    
    init(frame: CGRect, viewController : UIViewController, id: Int64, arguments: Any?, messenger: FlutterBinaryMessenger) {
        uiView = UIView(frame: frame)
        channel =  FlutterMethodChannel(
            name: UnityMediationConstants.BANNER_AD_CHANNEL + "_" + String(id),  binaryMessenger:  messenger)
        super.init()
        let args = arguments as! [String: Any]? ?? [:]
        let adUnitId =  args[UnityMediationConstants.AD_UNIT_ID_PARAMETER] as? String ?? ""
        
        let width =  args[UnityMediationConstants.WIDTH_PARAMETER] as? CGFloat
        let height = args[UnityMediationConstants.HEIGHT_PARAMETER] as? CGFloat
        let size = CGSize(width: width ?? 320.0, height: height ?? 50.0)
        let bannerView = UMSBannerAdView(adUnitId: adUnitId, bannerAdViewSize: UMSBannerAdViewSize(from: size))

        bannerView.delegate = self
        bannerView.load(with: viewController)

        uiView.addSubview(bannerView)
        uiView.layoutIfNeeded()
    }
    
    func view() -> UIView {
        uiView
    }
    
    func onBannerAdViewLoaded(_ bannerAdView: UMSBannerAdView?) {
        channel.invokeMethod(UnityMediationConstants.BANNER_LOADED_METHOD,
                             arguments: [UnityMediationConstants.AD_UNIT_ID_PARAMETER: bannerAdView?.adUnitId])
    }
    
    func onBannerAdViewFailedLoad(_ bannerAdView: UMSBannerAdView?, error: UMSLoadError, message: String?) {
        let arguments = [
            UnityMediationConstants.AD_UNIT_ID_PARAMETER: bannerAdView?.adUnitId,
            UnityMediationConstants.ERROR_CODE_PARAMETER: ErrorUtils.convertError(error),
            UnityMediationConstants.ERROR_MESSAGE_PARAMETER: message];

        channel.invokeMethod(UnityMediationConstants.BANNER_ERROR_METHOD, arguments: arguments);
    }
    
    func onBannerAdViewClicked(_ bannerAdView: UMSBannerAdView?) {
        channel.invokeMethod(UnityMediationConstants.BANNER_CLICKED_METHOD,
                             arguments: [UnityMediationConstants.AD_UNIT_ID_PARAMETER: bannerAdView?.adUnitId])
    }
    
    func onBannerAdViewRefreshed(_ bannerAdView: UMSBannerAdView?, error: Error?) {
        if (error != nil) {
            onBannerAdViewFailedLoad(bannerAdView, error: .unknown, message: error!.localizedDescription)
        }
    }
}

