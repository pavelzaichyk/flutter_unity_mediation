import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unity_mediation/unity_mediation.dart';

void main() {
  const MethodChannel channel = MethodChannel('unity_mediation');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await UnityMediation.platformVersion, '42');
  });
}
