package com.rebeloid.unity_mediation;

public final class UnityMediationConstants {

    public static final String MAIN_CHANNEL = "com.rebeloid.unity_mediation";
    public static final String VIDEO_AD_CHANNEL = MAIN_CHANNEL + "/videoAd";
    public static final String AD_UNIT_ID_PARAMETER = "adUnitId";
    public static final String ERROR_CODE_PARAMETER = "errorCode";
    public static final String ERROR_MESSAGE_PARAMETER = "errorMessage";

    //initialize
    public static final String INIT_METHOD = "init";
    public static final String INIT_STATE_METHOD = "initState";
    public static final String GAME_ID_PARAMETER = "gameId";
    public static final String INIT_COMPLETE_METHOD = "initComplete";
    public static final String INIT_FAILED_METHOD = "initFailed";

    //load
    public static final String LOAD_REWARDED_AD_METHOD = "loadRewardedAd";
    public static final String LOAD_INTERSTITIAL_AD_METHOD = "loadInterstitialAd";
    public static final String LOAD_COMPLETE_METHOD = "loadComplete";
    public static final String LOAD_FAILED_METHOD = "loadFailed";

    //show
    public static final String SHOW_REWARDED_AD_METHOD = "showRewardedAd";
    public static final String SHOW_INTERSTITIAL_AD_METHOD = "showInterstitialAd";
    public static final String SHOW_REWARDED_METHOD = "showRewarded";
    public static final String SHOW_FAILED_METHOD = "showFailed";
    public static final String SHOW_START_METHOD = "showStart";
    public static final String SHOW_CLOSED_METHOD = "showClosed";
    public static final String SHOW_CLICK_METHOD = "showClick";
    public static final String REWARD_TYPE_PARAMETER = "rewardType";
    public static final String REWARD_AMOUNT_PARAMETER = "rewardAmountType";
    public static final String STS_USER_ID_PARAMETER = "userId";
    public static final String STS_CUSTOMIZED_DATA_PARAMETER = "customizedData";

    //state
    public static final String REWARDED_AD_STATE_METHOD = "rewardedAdState";
    public static final String INTERSTITIAL_AD_STATE_METHOD = "interstitialAdStateMethod";

    private UnityMediationConstants() {
    }
}
