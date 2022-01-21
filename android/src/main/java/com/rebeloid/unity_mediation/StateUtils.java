package com.rebeloid.unity_mediation;

import com.unity3d.mediation.AdState;

public final class StateUtils {

    public static String convertState(AdState state) {
        switch (state) {
            case UNLOADED:
                return "unloaded";
            case LOADING:
                return "loading";
            case LOADED:
                return "loaded";
            case SHOWING:
                return "showing";
            default:
                return "";
        }
    }

    private StateUtils() {
    }
}
