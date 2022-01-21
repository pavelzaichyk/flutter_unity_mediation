class AdMethodChannelCaller : NSObject {
    var adUnitChannels: [String: FlutterMethodChannel];
    let messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger, adUnitChannels: [String: FlutterMethodChannel]) {
        self.messenger = messenger
        self.adUnitChannels = adUnitChannels
    }
    
    func invokeMethod(_ methodName: String, _ adUnitId: String) {
        invokeMethod(methodName, adUnitId, arguments: [:])
    }

    func invokeMethod(_ methodName: String, _ adUnitId: String, errorCode: String, errorMessage: String){
        var arguments: [String:String] = [:]
        arguments[UnityMediationConstants.ERROR_CODE_PARAMETER]=errorCode
        arguments[UnityMediationConstants.ERROR_MESSAGE_PARAMETER]=errorMessage
        invokeMethod(methodName, adUnitId, arguments: arguments)
    }

    func invokeMethod(_ methodName: String, _ adUnitId: String, arguments: [String:String]){
        var args = arguments;
        args[UnityMediationConstants.AD_UNIT_ID_PARAMETER]=adUnitId
        var channel = adUnitChannels[adUnitId]
        if (channel == nil) {
            channel = FlutterMethodChannel(name: UnityMediationConstants.VIDEO_AD_CHANNEL + "_" + adUnitId, binaryMessenger: messenger)
            adUnitChannels[adUnitId] = channel
        }
        channel?.invokeMethod(methodName, arguments: args)
    }
}
