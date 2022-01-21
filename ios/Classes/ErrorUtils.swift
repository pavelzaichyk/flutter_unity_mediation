import UnityMediationSdk

class ErrorUtils {
    static func convertError(_ error: UMSLoadError) -> String {
        switch (error) {
        case .unknown:
            return "unknown";
        case .none:
            return ""
        case .noFill:
            return "noFill";
        case .networkError:
            return "networkError";
        case .sdkNotInitialized:
            return "sdkNotInitialized";
        @unknown default:
            return ""
        }
    }
    
    static func convertError(_ error: UMSShowError) -> String {
        switch (error) {
        case .unknown:
            return "unknown";
        case .adNotLoaded:
            return "notLoaded";
        case .adNetworkError:
            return "networkError";
        @unknown default:
            return ""
        }
    }
}
