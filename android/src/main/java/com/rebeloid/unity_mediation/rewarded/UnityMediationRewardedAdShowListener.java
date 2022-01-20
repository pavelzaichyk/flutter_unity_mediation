package com.rebeloid.unity_mediation.rewarded;

import com.rebeloid.unity_mediation.AdMethodChannelCaller;
import com.rebeloid.unity_mediation.ErrorUtils;
import com.rebeloid.unity_mediation.UnityMediationConstants;
import com.unity3d.mediation.IReward;
import com.unity3d.mediation.IRewardedAdShowListener;
import com.unity3d.mediation.RewardedAd;
import com.unity3d.mediation.errors.ShowError;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class UnityMediationRewardedAdShowListener extends AdMethodChannelCaller implements IRewardedAdShowListener {

    public UnityMediationRewardedAdShowListener(BinaryMessenger binaryMessenger, Map<String, MethodChannel> adUnitChannels) {
        super(binaryMessenger, adUnitChannels);
    }

    @Override
    public void onRewardedShowed(RewardedAd rewardedAd) {
        invokeMethod(UnityMediationConstants.SHOW_START_METHOD, rewardedAd.getAdUnitId());
    }

    @Override
    public void onRewardedClicked(RewardedAd rewardedAd) {
        invokeMethod(UnityMediationConstants.SHOW_CLICK_METHOD, rewardedAd.getAdUnitId());
    }

    @Override
    public void onRewardedClosed(RewardedAd rewardedAd) {
        invokeMethod(UnityMediationConstants.SHOW_CLOSED_METHOD, rewardedAd.getAdUnitId());
    }

    @Override
    public void onRewardedFailedShow(RewardedAd rewardedAd, ShowError error, String message) {
        invokeMethod(UnityMediationConstants.SHOW_FAILED_METHOD, rewardedAd.getAdUnitId(),
                ErrorUtils.convertError(error), message);
    }

    @Override
    public void onUserRewarded(RewardedAd rewardedAd, IReward reward) {
        Map<String, String> arguments = new HashMap<>();
        arguments.put(UnityMediationConstants.REWARD_TYPE_PARAMETER, reward.getType());
        arguments.put(UnityMediationConstants.REWARD_AMOUNT_PARAMETER, reward.getAmount());
        invokeMethod(UnityMediationConstants.SHOW_REWARDED_METHOD, rewardedAd.getAdUnitId(), arguments);
    }
}
