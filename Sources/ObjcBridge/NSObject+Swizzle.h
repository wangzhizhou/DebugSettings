//
//  NSObject+Swizzle.h
//  
//
//  Created by joker on 2023/10/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(Swizzle)

+ (void)ds_swizzleClassMethodWithOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel;

+ (void)ds_swizzleInstanceMethodWithOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel;

@end

NS_ASSUME_NONNULL_END
