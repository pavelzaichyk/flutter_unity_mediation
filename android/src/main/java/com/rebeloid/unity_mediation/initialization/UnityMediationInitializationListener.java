package com.rebeloid.unity_mediation.initialization;

import com.rebeloid.unity_mediation.ErrorUtils;
import com.rebeloid.unity_mediation.UnityMediationConstants;
import com.unity3d.mediation.IInitializationListener;
import com.unity3d.mediation.errors.SdkInitializationError;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class UnityMediationInitializationListener implements IInitializationListener {
    private final MethodChannel channel;

    public UnityMediationInitializationListener(MethodChannel channel) {
        this.channel = channel;
    }

    @Override
    public void onInitializationComplete() {
        channel.invokeMethod(UnityMediationConstants.INIT_COMPLETE_METHOD, new HashMap<>());
    }

    @Override
    public void onInitializationFailed(SdkInitializationError error, String message) {
        Map<String, String> arguments = new HashMap<>();
        arguments.put(UnityMediationConstants.ERROR_CODE_PARAMETER, ErrorUtils.convertError(error));
        arguments.put(UnityMediationConstants.ERROR_MESSAGE_PARAMETER, message);
        channel.invokeMethod(UnityMediationConstants.INIT_FAILED_METHOD, arguments);
    }

}
