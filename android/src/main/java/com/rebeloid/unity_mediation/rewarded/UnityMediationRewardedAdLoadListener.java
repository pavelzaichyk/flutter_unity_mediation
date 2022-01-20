package com.rebeloid.unity_mediation.rewarded;

import com.rebeloid.unity_mediation.AdMethodChannelCaller;
import com.rebeloid.unity_mediation.ErrorUtils;
import com.rebeloid.unity_mediation.UnityMediationConstants;
import com.unity3d.mediation.IRewardedAdLoadListener;
import com.unity3d.mediation.RewardedAd;
import com.unity3d.mediation.errors.LoadError;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class UnityMediationRewardedAdLoadListener extends AdMethodChannelCaller implements IRewardedAdLoadListener {

    public UnityMediationRewardedAdLoadListener(BinaryMessenger binaryMessenger, Map<String, MethodChannel> adUnitChannels) {
        super(binaryMessenger, adUnitChannels);
    }

    @Override
    public void onRewardedLoaded(RewardedAd rewardedAd) {
        invokeMethod(UnityMediationConstants.LOAD_COMPLETE_METHOD, rewardedAd.getAdUnitId());
    }

    @Override
    public void onRewardedFailedLoad(RewardedAd rewardedAd, LoadError error, String message) {
        invokeMethod(UnityMediationConstants.LOAD_FAILED_METHOD, rewardedAd.getAdUnitId(),
                ErrorUtils.convertError(error), message);
    }
}
