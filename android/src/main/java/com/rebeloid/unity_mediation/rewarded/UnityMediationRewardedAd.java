package com.rebeloid.unity_mediation.rewarded;

import android.app.Activity;

import com.rebeloid.unity_mediation.StateUtils;
import com.rebeloid.unity_mediation.UnityMediationConstants;
import com.unity3d.mediation.IRewardedAdLoadListener;
import com.unity3d.mediation.IRewardedAdShowListener;
import com.unity3d.mediation.InterstitialAd;
import com.unity3d.mediation.RewardedAd;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class UnityMediationRewardedAd {
    private final Map<String, RewardedAd> ads;
    private final IRewardedAdLoadListener loadListener;
    private final IRewardedAdShowListener showListener;
    private Activity activity;

    public UnityMediationRewardedAd(BinaryMessenger binaryMessenger) {
        ads = new HashMap<>();
        Map<String, MethodChannel> adUnitChannels = new HashMap<>();
        loadListener = new UnityMediationRewardedAdLoadListener(binaryMessenger, adUnitChannels);
        showListener = new UnityMediationRewardedAdShowListener(binaryMessenger, adUnitChannels);
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public boolean load(Map<?, ?> arguments) {
        RewardedAd ad = getAd(arguments);
        ad.load(loadListener);
        return true;
    }

    public boolean show(Map<?, ?> arguments) {
        RewardedAd ad = getAd(arguments);
        ad.show(showListener);
        return true;
    }

    public String getState(Map<?, ?> arguments) {
        RewardedAd ad = getAd(arguments);
        return StateUtils.convertState(ad.getAdState());
    }

    private RewardedAd getAd(Map<?, ?> arguments) {
        String adUnitId = (String) arguments.get(UnityMediationConstants.AD_UNIT_ID_PARAMETER);
        RewardedAd ad = ads.get(adUnitId);
        if (ad != null) {
            return ad;
        }

        RewardedAd newAd = new RewardedAd(activity, adUnitId);
        ads.put(adUnitId, newAd);
        return newAd;
    }
}
