import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_permission_manager_method_channel.dart';

abstract class FlutterPermissionManagerPlatform extends PlatformInterface {
  /// Constructs a FlutterPermissionManagerPlatform.
  FlutterPermissionManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPermissionManagerPlatform _instance =
      MethodChannelFlutterPermissionManager();

  /// The default instance of [FlutterPermissionManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPermissionManager].
  static FlutterPermissionManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPermissionManagerPlatform] when
  /// they register themselves.
  static set instance(FlutterPermissionManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getNotificationStatus() {
    throw UnimplementedError(
        'getNotificationStatus() has not been implemented.');
  }

  Future<String?> requestNotificationPermission() {
    throw UnimplementedError(
        'requestNotificationPermission() has not been implemented.');
  }
}
