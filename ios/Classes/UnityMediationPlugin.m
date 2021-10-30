#import "UnityMediationPlugin.h"
#if __has_include(<unity_mediation/unity_mediation-Swift.h>)
#import <unity_mediation/unity_mediation-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "unity_mediation-Swift.h"
#endif

@implementation UnityMediationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUnityMediationPlugin registerWithRegistrar:registrar];
}
@end
