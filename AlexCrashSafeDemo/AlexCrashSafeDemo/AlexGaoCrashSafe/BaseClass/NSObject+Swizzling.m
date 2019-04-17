//
//  NSObject+Swizzling.m
//  test
//
//  Created by 高莹莹 on 2019/4/16.
//  Copyright © 2019年 高莹莹. All rights reserved.
//

#import "NSObject+Swizzling.h"

@implementation NSObject (Swizzling)
/**
 *  类方法的交换
 *
 *  @param anClass    哪个类
 *  @param oldMethodSel 方法1
 *  @param newMethodSel 方法2
 */
+ (void)exchangeClassMethod:(Class)anClass oldMethodSel:(SEL)oldMethodSel newMethodSel:(SEL)newMethodSel {
    Method oldMethod = class_getClassMethod(anClass, oldMethodSel);
    Method newMethod2 = class_getClassMethod(anClass, newMethodSel);
    method_exchangeImplementations(oldMethod, newMethod2);
}


/**
 *  对象方法的交换
 *
 *  @param anClass    哪个类
 *  @param oldMethodSel 方法1(原本的方法)
 *  @param newMethodSel 方法2(要替换成的方法)
 */
+ (void)exchangeInstanceMethod:(Class)anClass oldMethodSel:(SEL)oldMethodSel newMethodSel:(SEL)newMethodSel {
    
    
    Method originalMethod = class_getInstanceMethod(anClass, oldMethodSel);
    Method swizzledMethod = class_getInstanceMethod(anClass, newMethodSel);
    
    BOOL didAddMethod =
    class_addMethod(anClass,
                    oldMethodSel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(anClass,
                            newMethodSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

@end
