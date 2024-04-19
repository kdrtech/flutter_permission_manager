import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_permission_manager/flutter_permission_manager.dart';
import 'package:flutter_permission_manager/flutter_permission_manager_platform_interface.dart';
import 'package:flutter_permission_manager/flutter_permission_manager_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPermissionManagerPlatform
    with MockPlatformInterfaceMixin
    implements FlutterPermissionManagerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> getNotificationStatus() {
    return Future(() => "");
  }

  @override
  Future<String?> requestNotificationPermission() {
    return Future(() => "");
  }
}

void main() {
  final FlutterPermissionManagerPlatform initialPlatform =
      FlutterPermissionManagerPlatform.instance;

  test('$MethodChannelFlutterPermissionManager is the default instance', () {
    expect(
        initialPlatform, isInstanceOf<MethodChannelFlutterPermissionManager>());
  });

  test('getPlatformVersion', () async {
    FlutterPermissionManager flutterPermissionManagerPlugin =
        FlutterPermissionManager();
    MockFlutterPermissionManagerPlatform fakePlatform =
        MockFlutterPermissionManagerPlatform();
    FlutterPermissionManagerPlatform.instance = fakePlatform;

    expect(await flutterPermissionManagerPlugin.getPlatformVersion(), '42');
  });
}
