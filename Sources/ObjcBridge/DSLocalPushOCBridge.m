//
//  DSLocalPushOCBridge.m
//  Debugger
//
//  Created by joker on 2022/11/4.
//

#import "DSLocalPushOCBridge.h"
#import <objc/message.h>

@implementation DSLocalPushOCBridge
+ (UNPushNotificationTrigger *)createMockPushNotificationTrigger {
    
    // 私有API调用，只在调试环境下使用，不要带上线
    // 调用私用方法，进行实例创建，参考私有API链接：
    // https://developer.limneos.net/index.php?ios=11.1.2&framework=UserNotifications.framework&header=UNPushNotificationTrigger.h
    
    SEL selector = NSSelectorFromString(@"triggerWithContentAvailable:mutableContent:");
    UNPushNotificationTrigger * ret = ((UNPushNotificationTrigger * (*)(id, SEL, id, id))objc_msgSend)(UNPushNotificationTrigger.class, selector, @NO, @NO);
    return ret;
}
@end
