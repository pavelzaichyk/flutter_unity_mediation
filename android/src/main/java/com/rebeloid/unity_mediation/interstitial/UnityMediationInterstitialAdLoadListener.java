package com.rebeloid.unity_mediation.interstitial;

import com.rebeloid.unity_mediation.AdMethodChannelCaller;
import com.rebeloid.unity_mediation.ErrorUtils;
import com.rebeloid.unity_mediation.UnityMediationConstants;
import com.unity3d.mediation.IInterstitialAdLoadListener;
import com.unity3d.mediation.InterstitialAd;
import com.unity3d.mediation.errors.LoadError;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class UnityMediationInterstitialAdLoadListener extends AdMethodChannelCaller implements IInterstitialAdLoadListener {

    public UnityMediationInterstitialAdLoadListener(BinaryMessenger binaryMessenger, Map<String, MethodChannel> adUnitChannels) {
        super(binaryMessenger, adUnitChannels);
    }

    @Override
    public void onInterstitialLoaded(InterstitialAd interstitialAd) {
        invokeMethod(UnityMediationConstants.LOAD_COMPLETE_METHOD, interstitialAd.getAdUnitId());
    }

    @Override
    public void onInterstitialFailedLoad(InterstitialAd interstitialAd, LoadError error, String message) {
        invokeMethod(UnityMediationConstants.LOAD_FAILED_METHOD, interstitialAd.getAdUnitId(),
                ErrorUtils.convertError(error), message);
    }

}
