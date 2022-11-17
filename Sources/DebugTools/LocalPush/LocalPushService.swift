//
//  LocalPushService.swift
//  Debugger
//
//  Created by joker on 2022/11/3.
//

import Foundation
import UIKit
import UserNotifications
#if canImport(ObjcBridge)
import ObjcBridge
#endif

@available(iOS 10.0, *)
@objc public enum LocalPushServiceError: Int, Error {
    case userInfoInvalid
    case triggerDurationInvalid
    case requestNotificationPermissionFailed
}

@available(iOS 10.0, *)
@objc public enum LocalPushType: Int {
    case all
    case foreground
    case background
}

@available(iOS 10.0, *)
@objcMembers
public class LocalPushService: NSObject {
    /// 单例实现
    public static let shared = LocalPushService()
    private override init() {}
    
    public static let localPushIdentifier = "com.debug.settings.local.push.identifier"
    weak var originalUserNotificationCenterDelegate: UNUserNotificationCenterDelegate?
    public func restoreOriginalUserNotificationCenterDelegate() {
        UNUserNotificationCenter.current().delegate = self.originalUserNotificationCenterDelegate
    }
    deinit {
        self.restoreOriginalUserNotificationCenterDelegate()
    }
    var localPushType: LocalPushType = .all
}

@available(iOS 10.0, *)
public extension LocalPushService {
    var canShowLocalPush: Bool {
        let appStatus = UIApplication.shared.applicationState
        switch self.localPushType {
        case .all:
            return true
        case .foreground:
            return appStatus == .active
        case .background:
            return appStatus != .active
        }
    }
    func sendLocalNotification(with userInfo: [String: Any]?,
                               triggerAfterNow seconds: TimeInterval,
                               type: LocalPushType = .all,
                               completionHandler: @escaping (_ error: Error?) -> Void) {
        
        guard let userInfo = userInfo, let aps = userInfo["aps"] as? [String: Any], let alert = aps["alert"] as? [String: Any]
        else {
            completionHandler(LocalPushServiceError.userInfoInvalid)
            return
        }
        
        guard seconds > 0
        else {
            completionHandler(LocalPushServiceError.triggerDurationInvalid)
            return
        }
        
        self.localPushType = type
        
        if self.originalUserNotificationCenterDelegate == nil && UNUserNotificationCenter.current().delegate !== self {
            self.originalUserNotificationCenterDelegate = UNUserNotificationCenter.current().delegate
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            
            DispatchQueue.main.async {
                guard granted
                else {
                    completionHandler(LocalPushServiceError.requestNotificationPermissionFailed)
                    return
                }
                
                UNUserNotificationCenter.current().delegate = self
                let localUserNotificationContent = UNMutableNotificationContent()
                localUserNotificationContent.userInfo = userInfo
                localUserNotificationContent.title = "🦄\(alert["title"] ?? "")"
                localUserNotificationContent.subtitle = "\(alert["subtitle"] ?? "")"
                localUserNotificationContent.body = "\(alert["body"] ?? "")"
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
                let request = UNNotificationRequest(identifier: Self.localPushIdentifier,
                                                    content: localUserNotificationContent,
                                                    trigger: trigger)
                
                let center = UNUserNotificationCenter.current()
                center.add(request) { error in
                    if error == nil {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }
                    completionHandler(error)
                }
            }
        }
    }
}

@available(iOS 10.0, *)
extension LocalPushService: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        guard canShowLocalPush
        else {
            return
        }
        if let delegate = self.originalUserNotificationCenterDelegate, delegate.responds(to: #selector(UNUserNotificationCenterDelegate.userNotificationCenter(_:willPresent:withCompletionHandler:))) {
            delegate.userNotificationCenter?(center, willPresent: notification, withCompletionHandler: completionHandler)
        } else {
            completionHandler([.alert, .badge, .sound])
        }
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if let delegate = self.originalUserNotificationCenterDelegate, delegate.responds(to: #selector(UNUserNotificationCenterDelegate.userNotificationCenter(_:didReceive:withCompletionHandler:))) {
            
            if response.notification.request.identifier == Self.localPushIdentifier {
                // 为本地调试工具发出的推送请求， 运行时修改readonly属性值, 让其按照远程推送的类型进行处理
                let mockRemoteNotificationTrigger = DSLocalPushOCBridge.createMockPushNotificationTrigger()
                response.notification.request.setValue(mockRemoteNotificationTrigger, forKeyPath: "trigger")
            }
            
            delegate.userNotificationCenter?(center, didReceive: response, withCompletionHandler: {
                completionHandler()
                self.restoreOriginalUserNotificationCenterDelegate()
            })
        }
        else {
            self.restoreOriginalUserNotificationCenterDelegate()
            completionHandler()
        }
    }
}

