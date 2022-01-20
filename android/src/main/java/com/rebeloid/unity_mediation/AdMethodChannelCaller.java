package com.rebeloid.unity_mediation;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public abstract class AdMethodChannelCaller {
    private final BinaryMessenger binaryMessenger;
    private final Map<String, MethodChannel> adUnitChannels;

    protected AdMethodChannelCaller(BinaryMessenger binaryMessenger, Map<String, MethodChannel> adUnitChannels) {
        this.binaryMessenger = binaryMessenger;
        this.adUnitChannels = adUnitChannels;
    }

    protected void invokeMethod(String methodName, String adUnitId) {
        invokeMethod(methodName, adUnitId, new HashMap<>());
    }

    protected void invokeMethod(String methodName, String adUnitId, String errorCode, String errorMessage) {
        Map<String, String> arguments = new HashMap<>();
        arguments.put(UnityMediationConstants.ERROR_CODE_PARAMETER, errorCode);
        arguments.put(UnityMediationConstants.ERROR_MESSAGE_PARAMETER, errorMessage);
        invokeMethod(methodName, adUnitId, arguments);
    }

    protected void invokeMethod(String methodName, String adUnitId, Map<String, String> arguments) {
        arguments.put(UnityMediationConstants.AD_UNIT_ID_PARAMETER, adUnitId);
        MethodChannel channel = adUnitChannels.get(adUnitId);
        if (channel == null) {
            channel = new MethodChannel(binaryMessenger, UnityMediationConstants.VIDEO_AD_CHANNEL + "_" + adUnitId);
            adUnitChannels.put(adUnitId, channel);
        }
        channel.invokeMethod(methodName, arguments);
    }
}
