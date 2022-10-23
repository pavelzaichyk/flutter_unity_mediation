package com.rebeloid.unity_mediation.banner;

import androidx.annotation.Nullable;

import com.rebeloid.unity_mediation.ErrorUtils;
import com.rebeloid.unity_mediation.UnityMediationConstants;
import com.unity3d.mediation.BannerAdView;
import com.unity3d.mediation.IBannerAdViewListener;
import com.unity3d.mediation.errors.LoadError;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

class BannerAdListener implements IBannerAdViewListener {
    private final MethodChannel channel;

    public BannerAdListener(MethodChannel channel) {
        this.channel = channel;
    }

    /**
     * A callback method triggered by a successfully loaded banner ad.
     */
    @Override
    public void onBannerAdViewLoaded(BannerAdView bannerAdView) {
        Map<String, String> arguments = new HashMap<>();
        arguments.put(UnityMediationConstants.AD_UNIT_ID_PARAMETER, bannerAdView.getAdUnitId());

        channel.invokeMethod(UnityMediationConstants.BANNER_LOADED_METHOD, arguments);
    }

    /**
     * A callback method triggered by a banner ad failing to load.
     */
    @Override
    public void onBannerAdViewFailedLoad(BannerAdView bannerAdView, LoadError loadError, String errorMessage) {
        Map<String, String> arguments = new HashMap<>();
        arguments.put(UnityMediationConstants.AD_UNIT_ID_PARAMETER, bannerAdView.getAdUnitId());
        arguments.put(UnityMediationConstants.ERROR_CODE_PARAMETER, ErrorUtils.convertError(loadError));
        arguments.put(UnityMediationConstants.ERROR_MESSAGE_PARAMETER, errorMessage);

        channel.invokeMethod(UnityMediationConstants.BANNER_ERROR_METHOD, arguments);
    }

    /**
     * A callback method triggered when the user clicks a banner ad.
     */
    @Override
    public void onBannerAdViewClicked(BannerAdView bannerAdView) {
        Map<String, String> arguments = new HashMap<>();
        arguments.put(UnityMediationConstants.AD_UNIT_ID_PARAMETER, bannerAdView.getAdUnitId());

        channel.invokeMethod(UnityMediationConstants.BANNER_CLICKED_METHOD, arguments);
    }

    /**
     * A callback method triggered when the user refreshes a banner ad.
     */
    @Override
    public void onBannerAdViewRefreshed(BannerAdView bannerAdView, @Nullable LoadError loadError, @Nullable String errorMessage) {
        if (loadError != null) {
            onBannerAdViewFailedLoad(bannerAdView, loadError, errorMessage);
        }
    }
}