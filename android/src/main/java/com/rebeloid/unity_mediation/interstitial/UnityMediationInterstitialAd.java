package com.rebeloid.unity_mediation.interstitial;

import android.app.Activity;

import com.rebeloid.unity_mediation.StateUtils;
import com.rebeloid.unity_mediation.UnityMediationConstants;
import com.unity3d.mediation.IInterstitialAdLoadListener;
import com.unity3d.mediation.IInterstitialAdShowListener;
import com.unity3d.mediation.InterstitialAd;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class UnityMediationInterstitialAd {
    private final Map<String, InterstitialAd> ads;
    private final IInterstitialAdLoadListener loadListener;
    private final IInterstitialAdShowListener showListener;
    private Activity activity;

    public UnityMediationInterstitialAd(BinaryMessenger binaryMessenger) {
        ads = new HashMap<>();
        Map<String, MethodChannel> adUnitChannels = new HashMap<>();
        loadListener = new UnityMediationInterstitialAdLoadListener(binaryMessenger, adUnitChannels);
        showListener = new UnityMediationInterstitialAdShowListener(binaryMessenger, adUnitChannels);
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public boolean load(Map<?, ?> arguments) {
        InterstitialAd ad = getAd(arguments);
        ad.load(loadListener);
        return true;
    }

    public boolean show(Map<?, ?> arguments) {
        InterstitialAd ad = getAd(arguments);
        ad.show(showListener);
        return true;
    }

    public String getState(Map<?, ?> arguments) {
        InterstitialAd ad = getAd(arguments);
        return StateUtils.convertState(ad.getAdState());
    }

    private InterstitialAd getAd(Map<?, ?> arguments) {
        String adUnitId = (String) arguments.get(UnityMediationConstants.AD_UNIT_ID_PARAMETER);
        InterstitialAd ad = ads.get(adUnitId);
        if (ad != null) {
            return ad;
        }

        InterstitialAd newAd = new InterstitialAd(activity, adUnitId);
        ads.put(adUnitId, newAd);
        return newAd;
    }
}
