import 'flutter_permission_manager_platform_interface.dart';

class FlutterPermissionManager {
  Future<String?> getPlatformVersion() {
    return FlutterPermissionManagerPlatform.instance.getPlatformVersion();
  }

  Future<String?> getNotificationStatus() {
    return FlutterPermissionManagerPlatform.instance.getNotificationStatus();
  }

  Future<String?> requestNotificationPermission() {
    return FlutterPermissionManagerPlatform.instance
        .requestNotificationPermission();
  }
}
