struct UnityMediationConstants {
    static let MAIN_CHANNEL = "com.rebeloid.unity_mediation";
    static let VIDEO_AD_CHANNEL = MAIN_CHANNEL + "/videoAd";
    
    static let AD_UNIT_ID_PARAMETER = "adUnitId";
    static let ERROR_CODE_PARAMETER = "errorCode";
    static let ERROR_MESSAGE_PARAMETER = "errorMessage";
    
    //initialize
    static let INIT_METHOD = "init";
    static let GAME_ID_PARAMETER = "gameId";
    static let INIT_COMPLETE_METHOD = "initComplete";
    static let INIT_FAILED_METHOD = "initFailed";
    
    //load
    static let LOAD_REWARDED_AD_METHOD = "loadRewardedAd";
    static let LOAD_INTERSTITIAL_AD_METHOD = "loadInterstitialAd";
    static let LOAD_COMPLETE_METHOD = "loadComplete";
    static let LOAD_FAILED_METHOD = "loadFailed";
    
    //show
    static let SHOW_REWARDED_AD_METHOD = "showRewardedAd";
    static let SHOW_INTERSTITIAL_AD_METHOD = "showInterstitialAd";
    static let SHOW_REWARDED_METHOD = "showRewarded";
    static let SHOW_FAILED_METHOD = "showFailed";
    static let SHOW_START_METHOD = "showStart";
    static let SHOW_CLOSED_METHOD = "showClosed";
    static let SHOW_CLICK_METHOD = "showClick";
    static let  REWARD_TYPE_PARAMETER = "rewardType";
    static let  REWARD_AMOUNT_PARAMETER = "rewardAmountType";
    
}
