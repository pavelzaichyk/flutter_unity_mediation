package com.rebeloid.unity_mediation.banner;

import android.app.Activity;
import android.view.View;

import com.rebeloid.unity_mediation.UnityMediationConstants;
import com.unity3d.mediation.BannerAdView;
import com.unity3d.mediation.BannerAdViewSize;

import java.util.Map;
import java.util.Objects;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class BannerView implements PlatformView {
    private final BannerAdView bannerView;

    public BannerView(Activity activity, int id, Map<?, ?> args, BinaryMessenger messenger) {
        MethodChannel channel = new MethodChannel(messenger, UnityMediationConstants.BANNER_AD_CHANNEL + "_" + id);

        Integer width = (Integer) args.get(UnityMediationConstants.WIDTH_PARAMETER);
        Integer height = (Integer) args.get(UnityMediationConstants.HEIGHT_PARAMETER);
        BannerAdViewSize size = width == null || height == null ? BannerAdViewSize.BANNER : new BannerAdViewSize(width, height);

        bannerView = new BannerAdView(activity, (String) Objects.requireNonNull(args.get(UnityMediationConstants.AD_UNIT_ID_PARAMETER)), size);

        bannerView.setListener(new BannerAdListener(channel));
        bannerView.load();
    }

    @Override
    public View getView() {
        return bannerView;
    }

    @Override
    public void dispose() {
        bannerView.destroy();
    }
}