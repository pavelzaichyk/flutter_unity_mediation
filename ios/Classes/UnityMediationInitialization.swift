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
    
}
