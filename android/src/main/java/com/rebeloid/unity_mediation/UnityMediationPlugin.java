package com.rebeloid.unity_mediation;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.rebeloid.unity_mediation.initialization.UnityMediationInitialization;
import com.rebeloid.unity_mediation.interstitial.UnityMediationInterstitialAd;
import com.rebeloid.unity_mediation.rewarded.UnityMediationRewardedAd;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * UnityMediationPlugin
 */
public class UnityMediationPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {

    private BinaryMessenger binaryMessenger;
    private MethodChannel channel;
    private UnityMediationInitialization unityMediationInitialization;
    private UnityMediationInterstitialAd interstitialAd;
    private UnityMediationRewardedAd rewardedAd;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        binaryMessenger = flutterPluginBinding.getBinaryMessenger();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        Map<?, ?> arguments = (Map<?, ?>) call.arguments;
        switch (call.method) {
            case UnityMediationConstants.INIT_METHOD:
                result.success(unityMediationInitialization.initialize(arguments));
                break;
            case UnityMediationConstants.INIT_STATE_METHOD:
                result.success(unityMediationInitialization.getInitializationState());
                break;
            case UnityMediationConstants.LOAD_REWARDED_AD_METHOD:
                result.success(rewardedAd.load(arguments));
                break;
            case UnityMediationConstants.SHOW_REWARDED_AD_METHOD:
                result.success(rewardedAd.show(arguments));
                break;
            case UnityMediationConstants.LOAD_INTERSTITIAL_AD_METHOD:
                result.success(interstitialAd.load(arguments));
                break;
            case UnityMediationConstants.SHOW_INTERSTITIAL_AD_METHOD:
                result.success(interstitialAd.show(arguments));
                break;
            case UnityMediationConstants.REWARDED_AD_STATE_METHOD:
                result.success(rewardedAd.getState(arguments));
                break;
            case UnityMediationConstants.INTERSTITIAL_AD_STATE_METHOD:
                result.success(interstitialAd.getState(arguments));
                break;
            default:
                result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
        interstitialAd = new UnityMediationInterstitialAd(binaryMessenger);
        rewardedAd = new UnityMediationRewardedAd(binaryMessenger);
        Activity activity = activityPluginBinding.getActivity();
        interstitialAd.setActivity(activity);
        rewardedAd.setActivity(activity);
        channel = new MethodChannel(binaryMessenger, UnityMediationConstants.MAIN_CHANNEL);
        channel.setMethodCallHandler(this);
        unityMediationInitialization = new UnityMediationInitialization(channel);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {

    }

    @Override
    public void onDetachedFromActivity() {

    }
}
