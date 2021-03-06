package com.rebeloid.unity_mediation.initialization;

import com.rebeloid.unity_mediation.UnityMediationConstants;
import com.unity3d.mediation.IInitializationListener;
import com.unity3d.mediation.InitializationConfiguration;
import com.unity3d.mediation.InitializationState;
import com.unity3d.mediation.UnityMediation;

import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class UnityMediationInitialization {
    private final IInitializationListener initializationListener;

    public UnityMediationInitialization(MethodChannel channel) {
        this.initializationListener = new UnityMediationInitializationListener(channel);
    }

    public boolean initialize(Map<?, ?> arguments) {
        String gameId = (String) arguments.get(UnityMediationConstants.GAME_ID_PARAMETER);
        InitializationConfiguration configuration = InitializationConfiguration.builder()
                .setGameId(gameId)
                .setInitializationListener(initializationListener)
                .build();
        UnityMediation.initialize(configuration);
        return true;
    }

    public String getInitializationState() {
        InitializationState state = UnityMediation.getInitializationState();
        return convertState(state);
    }

    private String convertState(InitializationState state) {
        switch (state) {
            case UNINITIALIZED:
                return "uninitialized";
            case INITIALIZING:
                return "initializing";
            case INITIALIZED:
                return "initialized";
            default:
                return "";
        }
    }
}

