import UnityMediationSdk

class StateUtils {
    static func convertState(_ state: UMSAdState) -> String {
        switch (state) {
        case .unloaded:
            return "unloaded";
        case .loading:
            return "loading";
        case .loaded:
            return "loaded";
        case .showing:
            return "showing";
        @unknown default:
            return "";
        }
    }
}
