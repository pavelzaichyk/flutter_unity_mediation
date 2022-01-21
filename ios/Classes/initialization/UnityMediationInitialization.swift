import UnityMediationSdk

class UnityMediationInitialization {
    let initializationDelegate : UnityMediationInitializationDelegate;
    
    init(channel: FlutterMethodChannel) {
        self.initializationDelegate = UnityMediationInitializationDelegate(channel: channel)
    }
    
    public func initialize(_ args: NSDictionary) -> Bool {
        let gameId = args[UnityMediationConstants.GAME_ID_PARAMETER] as! String
        let configuration = UMSInitializationConfigurationBuilder()
            .setGameId(gameId)
            .setInitializationDelegate(initializationDelegate)
            .build()
        UMSUnityMediation.initialize(with: configuration)
        return true
    }
    
    public func getInitializationState() -> String {
        let state : UMSInitializationState = UMSUnityMediation.getInitializationState();
        return convertState(state)
    }
    
    func convertState(_ state: UMSInitializationState) -> String {
        switch (state) {
        case .uninitialized:
            return "uninitialized"
        case .initializing:
            return "initializing"
        case .initialized:
            return "initialized"
        @unknown default:
            return ""
        }
    }
    
}
