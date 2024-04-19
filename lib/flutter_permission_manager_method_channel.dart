import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_permission_manager_platform_interface.dart';

/// An implementation of [FlutterPermissionManagerPlatform] that uses method channels.
class MethodChannelFlutterPermissionManager
    extends FlutterPermissionManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_permission_manager');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getNotificationStatus() async {
    final status =
        await methodChannel.invokeMethod<String>('getNotificationStatus');
    return status;
  }

  @override
  Future<String?> requestNotificationPermission() async {
    final status = await methodChannel
        .invokeMethod<String>('requestNotificationPermission');
    return status;
  }
}
