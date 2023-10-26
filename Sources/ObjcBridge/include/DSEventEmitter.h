//
//  DSEventEmitter.h
//  
//
//  Created by joker on 2023/10/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DSEventType) {
    DSEventTypeShake,
    DSEventTypeAppDidFinishLaunching,
};

typedef void (^DSEventHandler)(DSEventType type);

@interface DSEventEmitter : NSObject

+ (void)addEventHandler:(DSEventHandler)handler forType:(DSEventType)type;

+ (void)removeEventHandler:(DSEventHandler)handler forType:(DSEventType)type;

@end

NS_ASSUME_NONNULL_END
