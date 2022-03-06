const mainChannel = "com.rebeloid.unity_mediation";
const videoAdChannel = mainChannel + "/videoAd";

const adUnitIdParameter = "adUnitId";
const errorCodeParameter = "errorCode";
const errorMessageParameter = "errorMessage";

//initialize
const initMethod = "init";
const initStateMethod = "initState";
const gameIdParameter = "gameId";
const initCompleteMethod = "initComplete";
const initFailedMethod = "initFailed";

//load
const loadRewardedAdMethod = 'loadRewardedAd';
const loadInterstitialAdMethod = 'loadInterstitialAd';
const loadCompleteMethod = "loadComplete";
const loadFailedMethod = "loadFailed";

//show
const showRewardedAdMethod = "showRewardedAd";
const showInterstitialAdMethod = "showInterstitialAd";
const showRewardedMethod = "showRewarded";
const showFailedMethod = "showFailed";
const showStartMethod = "showStart";
const showClosedMethod = "showClosed";
const showClickMethod = "showClick";
const rewardTypeParameter = "rewardType";
const rewardAmountParameter = "rewardAmountType";
const stsUserIdParameter = "userId";
const stsCustomizedDataParameter = "customizedData";

//state
const rewardedAdStateMethod = "rewardedAdState";
const interstitialAdStateMethod = "interstitialAdStateMethod";
