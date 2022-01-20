package com.rebeloid.unity_mediation.interstitial;

import com.rebeloid.unity_mediation.AdMethodChannelCaller;
import com.rebeloid.unity_mediation.ErrorUtils;
import com.rebeloid.unity_mediation.UnityMediationConstants;
import com.unity3d.mediation.IInterstitialAdShowListener;
import com.unity3d.mediation.InterstitialAd;
import com.unity3d.mediation.errors.ShowError;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class UnityMediationInterstitialAdShowListener extends AdMethodChannelCaller implements IInterstitialAdShowListener {

    public UnityMediationInterstitialAdShowListener(BinaryMessenger binaryMessenger, Map<String, MethodChannel> adUnitChannels) {
        super(binaryMessenger, adUnitChannels);
    }

    @Override
    public void onInterstitialShowed(InterstitialAd interstitialAd) {
        invokeMethod(UnityMediationConstants.SHOW_START_METHOD, interstitialAd.getAdUnitId());
    }

    @Override
    public void onInterstitialClicked(InterstitialAd interstitialAd) {
        invokeMethod(UnityMediationConstants.SHOW_CLICK_METHOD, interstitialAd.getAdUnitId());
    }

    @Override
    public void onInterstitialClosed(InterstitialAd interstitialAd) {
        invokeMethod(UnityMediationConstants.SHOW_CLOSED_METHOD, interstitialAd.getAdUnitId());
    }

    @Override
    public void onInterstitialFailedShow(InterstitialAd interstitialAd, ShowError error, String message) {
        invokeMethod(UnityMediationConstants.SHOW_FAILED_METHOD, interstitialAd.getAdUnitId(),
                ErrorUtils.convertError(error), message);
    }
}
