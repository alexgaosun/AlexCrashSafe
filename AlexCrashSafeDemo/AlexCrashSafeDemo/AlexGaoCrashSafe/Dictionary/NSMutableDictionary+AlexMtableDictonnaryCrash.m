//
//  NSMutableDictionary+AlexMtableDictonnaryCrash.m
//  test
//
//  Created by 高莹莹 on 2019/4/17.
//  Copyright © 2019年 高莹莹. All rights reserved.
//

#import "NSMutableDictionary+AlexMtableDictonnaryCrash.h"
#import "NSObject+Swizzling.h"
#import "AlexExceptionManger.h"
@implementation NSMutableDictionary (AlexMtableDictonnaryCrash)
+ (void)mutableDicExchangeCrashMethod
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class dictionaryM = NSClassFromString(@"__NSDictionaryM");
        //setObject:forKey:
        [NSMutableDictionary exchangeInstanceMethod:dictionaryM oldMethodSel:@selector(setObject:forKey:) newMethodSel:@selector(alex_NSDictionaryM_CrashSetObject:forKey:)];
        
        //setObject:forKeyedSubscript:
        if (CrashVersioniOS(11.0)) {
            [NSMutableDictionary exchangeInstanceMethod:dictionaryM oldMethodSel:@selector(setObject:forKeyedSubscript:) newMethodSel:@selector(alex_NSDictionaryM_CrashSetObject:forKeyedSubscript:)];
        }
    });
}
//__NSDictionaryM  setObject:forKey:
- (void)alex_NSDictionaryM_CrashSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    @try {
        [self alex_NSDictionaryM_CrashSetObject:anObject forKey:aKey];
    }
    @catch (NSException *exception) {
        [AlexExceptionManger handlerExceptionMessage:exception];
    }
    @finally {
        
    }
}
//__NSDictionaryM  setObject:forKeyedSubscript:
- (void)alex_NSDictionaryM_CrashSetObject:(id)anObject forKeyedSubscript:(id<NSCopying>)aKey {
    @try {
        [self alex_NSDictionaryM_CrashSetObject:anObject forKeyedSubscript:aKey];
    }
    @catch (NSException *exception) {
        [AlexExceptionManger handlerExceptionMessage:exception];
    }
    @finally {
        
    }
}
@end
