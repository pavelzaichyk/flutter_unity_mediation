package com.rebeloid.unity_mediation.banner;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class BannerAdFactory extends PlatformViewFactory {
    private final BinaryMessenger messenger;
    private Activity activity;

    public BannerAdFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    @NonNull
    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        return new BannerView(activity, viewId, (Map<?, ?>) args, this.messenger);
    }

}
