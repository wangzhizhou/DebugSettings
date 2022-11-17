//
//  DSLocalPushOCBridge.h
//  Debugger
//
//  Created by joker on 2022/11/4.
//

#import <UserNotifications/UNNotificationTrigger.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSLocalPushOCBridge : NSObject
+ (UNPushNotificationTrigger *)createMockPushNotificationTrigger API_AVAILABLE(ios(10.0));
@end

NS_ASSUME_NONNULL_END
