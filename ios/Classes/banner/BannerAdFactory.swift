import Flutter

class BannerAdFactory: NSObject, FlutterPlatformViewFactory {
    let messenger: FlutterBinaryMessenger
    let viewController : UIViewController;

    init(messenger: FlutterBinaryMessenger, viewController : UIViewController) {
        self.messenger = messenger
        self.viewController = viewController
        super.init()
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return BannerView(
            frame: frame,
            viewController: viewController,
            id: viewId,
            arguments: args,
            messenger: messenger)
    }
    
}
