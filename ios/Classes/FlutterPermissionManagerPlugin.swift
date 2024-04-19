import Flutter
import UIKit
import UserNotifications


public class FlutterPermissionManagerPlugin: NSObject, FlutterPlugin {
  
  

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_permission_manager", binaryMessenger: registrar.messenger())
    let instance = FlutterPermissionManagerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "getNotificationStatus":
      FlutterPermissionNotification.share.checkStatus { status in 
        result(status)
      }
    case "requestNotificationPermission":
      FlutterPermissionNotification.share.requestPermission() { status in 
        result(status)
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

public class FlutterPermissionNotification : NSObject{
   let currentNotification = UNUserNotificationCenter.current()
     static var share = FlutterPermissionNotification()
    func requestPermission(callback:  @escaping (String) -> ()) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Permission granted for local notifications")
                callback("granted")
            } else {
                if let error = error {
                    print("Error requesting permission: \(error.localizedDescription)")
                    callback("error")
                } else {
                    print("Permission denied for local notifications")
                    callback("denied")
                }
            }
        }
    }
    func checkStatus(callback:  @escaping (String) -> () ){
        currentNotification.getNotificationSettings(completionHandler: { (settings) in
        if settings.authorizationStatus == .notDetermined {
          // Notification permission is yet to be been asked go for it!
          callback("notDetermined")
        } else if settings.authorizationStatus == .denied {
          callback("denied")
          // Notification permission was denied previously, go to settings & privacy to re-enable the permission
        } else if settings.authorizationStatus == .authorized {
          // Notification permission already granted.
          callback("authorized")
        }
      })
    }
}