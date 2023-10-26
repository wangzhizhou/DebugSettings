//
//  DSEventEmitter.m
//
//
//  Created by joker on 2023/10/26.
//

#import "DSEventEmitter.h"
#import <UIKit/UIKit.h>
#import "NSObject+Swizzle.h"

@interface DSEventEmitter()
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSMutableArray<DSEventHandler> *> *eventHandlers;
@property (nonatomic, strong) dispatch_queue_t eventHandlerQueue;
@end

@implementation DSEventEmitter

+ (void)addEventHandler:(DSEventHandler)handler forType:(DSEventType)type {
    
    if ([DSEventEmitter sharedInstance].eventHandlers.count == 0) {
        return;
    }
    
    dispatch_async([DSEventEmitter sharedInstance].eventHandlerQueue, ^{
        
        NSMutableArray<DSEventHandler> *handlers = [DSEventEmitter sharedInstance].eventHandlers[@(type)];
        if(!handlers) {
            [DSEventEmitter sharedInstance].eventHandlers[@(type)] = [NSMutableArray arrayWithArray:@[handler]];
        } else {
            [handlers addObject:handler];
        }
    });
}

+ (void)removeEventHandler:(DSEventHandler)handler forType:(DSEventType)type {
    
    if ([DSEventEmitter sharedInstance].eventHandlers.count == 0) {
        return;
    }
    
    dispatch_async([DSEventEmitter sharedInstance].eventHandlerQueue, ^{
        
        NSMutableArray<DSEventHandler> *handlers = [DSEventEmitter sharedInstance].eventHandlers[@(type)];
        [handlers removeObject:handler];
    });
}

- (void)triggerEvent:(DSEventType)type {
    
    if (self.eventHandlers.count == 0) {
        return;
    }
    
    NSMutableArray<DSEventHandler> *handlers = [DSEventEmitter sharedInstance].eventHandlers[@(type)];
    if(handlers.count == 0) {
        return;
    }
    
    dispatch_async([DSEventEmitter sharedInstance].eventHandlerQueue, ^{
        [handlers enumerateObjectsUsingBlock:^(DSEventHandler  _Nonnull handler, NSUInteger idx, BOOL * _Nonnull stop) {
            handler(type);
        }];
    });
    
}

+ (instancetype)sharedInstance {
    static DSEventEmitter *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DSEventEmitter alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:_instance
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];
    });
    return _instance;
}

- (NSDictionary<NSNumber *,NSMutableArray<DSEventHandler> *> *)eventHandlers {
    if(!_eventHandlers) {
        _eventHandlers = [NSMutableDictionary dictionary];
    }
    return _eventHandlers;
}

- (dispatch_queue_t)eventHandlerQueue {
    if (!_eventHandlerQueue) {
        _eventHandlerQueue = dispatch_queue_create("com.debug.settings.event.emitter.event.handler.queue", DISPATCH_QUEUE_SERIAL);
    }
    return _eventHandlerQueue;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [self triggerEvent:DSEventTypeAppDidFinishLaunching];
}
@end

@implementation UIWindow(Shake)

+ (void)load {
    [DSEventEmitter sharedInstance];
    [self ds_swizzleInstanceMethodWithOriginSel:@selector(motionBegan:withEvent:) swizzledSel:@selector(ds_motionBegan:withEvent:)];
}

- (void)ds_motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (motion != UIEventSubtypeMotionShake) {
        return;
    }
    
    [[DSEventEmitter sharedInstance] triggerEvent:DSEventTypeShake];
}
@end
