//
//  NSObject+Swizzling.h
//  test
//
//  Created by 高莹莹 on 2019/4/16.
//  Copyright © 2019年 高莹莹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)
+ (void)exchangeClassMethod:(Class)anClass oldMethodSel:(SEL)oldMethodSel newMethodSel:(SEL)newMethodSel;
+ (void)exchangeInstanceMethod:(Class)anClass oldMethodSel:(SEL)oldMethodSel newMethodSel:(SEL)newMethodSel;
@end

NS_ASSUME_NONNULL_END
