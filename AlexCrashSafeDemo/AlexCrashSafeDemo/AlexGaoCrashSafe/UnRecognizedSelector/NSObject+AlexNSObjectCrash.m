//
//  NSObject+AlexNSObjectCrash.m
//  test
//
//  Created by 高莹莹 on 2019/4/17.
//  Copyright © 2019年 高莹莹. All rights reserved.
//

#import "NSObject+AlexNSObjectCrash.h"
#import "NSObject+Swizzling.h"
#import "AlexExceptionManger.h"
static NSString *methodSelErrorMsg;


static NSMutableArray *noneSelClassStrings;
static NSMutableArray *noneSelClassStringPrefixs;
@implementation NSObject (AlexNSObjectCrash)
+ (void)objectExchangeMethodOpenNoneSel:(BOOL)ifOpenNoneSel
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (ifOpenNoneSel) {
            noneSelClassStrings = [NSMutableArray array];
            [NSObject exchangeInstanceMethod:[self class] oldMethodSel:@selector(methodSignatureForSelector:) newMethodSel:@selector(alex_NSObject_CrashMethodSignatureForSelector:)];
            [NSObject exchangeInstanceMethod:[self class] oldMethodSel:@selector(forwardInvocation:) newMethodSel:@selector(alex_NSObject_CrashForwardInvocation:)];
        }
    });
}
- (NSMethodSignature *)alex_NSObject_CrashMethodSignatureForSelector:(SEL)aSelector{
    if (![self respondsToSelector:aSelector]) {
        methodSelErrorMsg = NSStringFromSelector(aSelector);
        NSMethodSignature *methodSignature = [self alex_NSObject_CrashMethodSignatureForSelector:aSelector];
        if (class_addMethod([self class], aSelector, class_getMethodImplementation([self class], @selector(tempProxyMethod)), "v@:")) {//方法参数的获取存在问题
            NSLog(@"临时方法添加成功-%@",NSStringFromSelector(@selector(tempProxyMethod)));
        }
        if (!methodSignature) {
            methodSignature = [self alex_NSObject_CrashMethodSignatureForSelector:aSelector];
        }
        
        return methodSignature;
        
    }else{
        return [self alex_NSObject_CrashMethodSignatureForSelector:aSelector];
    }
}
- (void)alex_NSObject_CrashForwardInvocation:(NSInvocation *)anInvocation {
    
    @try {
        [self alex_NSObject_CrashForwardInvocation:anInvocation];
        
    } @catch (NSException *exception) {
        [AlexExceptionManger handlerExceptionMessage:exception];
        
    } @finally {
        
    }
    
}
- (void)tempProxyMethod
{
    NSString *error = [NSString stringWithFormat:@"errorClass->:%@\n errorFuction->%@\n errorReason->UnRecognized Selector",NSStringFromClass([self class]),methodSelErrorMsg];
    NSLog(@"%@",error);
}
@end
