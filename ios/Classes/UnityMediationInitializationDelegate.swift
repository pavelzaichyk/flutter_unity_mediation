import UnityMediationSdk

class UnityMediationInitializationDelegate: NSObject, UMSInitializationDelegate {
    
    let channel : FlutterMethodChannel
    
    init(channel: FlutterMethodChannel) {
        self.channel = channel
    }
    
    func onInitializationComplete() {
        channel.invokeMethod(UnityMediationConstants.INIT_COMPLETE_METHOD, arguments: [])
    }
    
    func onInitializationFailed(_ errorCode: UMSSdkInitializationError, message: String!) {
        var arguments: [String:String] = [:]
        arguments[UnityMediationConstants.ERROR_CODE_PARAMETER]=convertError(errorCode)
        arguments[UnityMediationConstants.ERROR_MESSAGE_PARAMETER]=message
        channel.invokeMethod(UnityMediationConstants.INIT_FAILED_METHOD, arguments: arguments)
    }
    
    private func convertError(_ error: UMSSdkInitializationError) -> String {
        switch (error) {
        case .unknown:
            return  "unknown"
        case .networkError:
            return   "networkError"
        @unknown default:
            return "";
        }
    }
}
