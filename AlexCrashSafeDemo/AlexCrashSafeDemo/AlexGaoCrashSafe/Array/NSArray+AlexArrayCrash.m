//
//  NSArray+AlexArrayCrash.m
//  test
//
//  Created by 高莹莹 on 2019/4/16.
//  Copyright © 2019年 高莹莹. All rights reserved.
//

#import "NSArray+AlexArrayCrash.h"
#import "NSObject+Swizzling.h"
#import "AlexExceptionManger.h"
@implementation NSArray (AlexArrayCrash)
+ (void)arrExchangeCrashMethod{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSArray = NSClassFromString(@"NSArray");//常规数组有值的数组
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");//大于一个元素
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");//只有一个元素的数组
        Class __NSArray0 = NSClassFromString(@"__NSArray0");//空数组
        
        //objectsAtIndexes:
        //此交换方法解决 
        [NSArray exchangeInstanceMethod:__NSArray oldMethodSel:@selector(objectsAtIndexes:) newMethodSel:@selector(alex_NSArray_ObjectsAtIndexes:)];
        [NSArray exchangeInstanceMethod:__NSArrayI oldMethodSel:@selector(objectAtIndex:) newMethodSel:@selector(alex_NSArrayI_CrashObjectAtIndex:)];
        [NSArray exchangeInstanceMethod:__NSSingleObjectArrayI oldMethodSel:@selector(objectAtIndex:) newMethodSel:@selector(alex_NSSingleObjectArrayI_CrashObjectAtIndex:)];
        [NSArray exchangeInstanceMethod:__NSArray0 oldMethodSel:@selector(objectAtIndex:) newMethodSel:@selector(alex_NSArray0_CrashObjectAtIndex:)];
        
        if (CrashVersioniOS(11.0)) {
            [NSArray exchangeInstanceMethod:__NSArrayI oldMethodSel:@selector(objectAtIndexedSubscript:) newMethodSel:@selector(alex_NSArrayI_CrashObjectAtIndexedSubscript:)];
        }
    });
}
//__NSArrayI  objectAtIndex:
- (id)alex_NSArray_ObjectsAtIndexes:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self alex_NSArray_ObjectsAtIndexes:index];
    }
    @catch (NSException *exception) {//崩溃捕捉
        [AlexExceptionManger handlerExceptionMessage:exception];
    }
    @finally {
        return object;
    }
}
//__NSArrayI  objectAtIndex:
- (id)alex_NSArrayI_CrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self alex_NSArrayI_CrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {//崩溃捕捉
        [AlexExceptionManger handlerExceptionMessage:exception];
    }
    @finally {
        return object;
    }
}
//__NSSingleObjectArrayI  objectAtIndex:
- (id)alex_NSSingleObjectArrayI_CrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self alex_NSSingleObjectArrayI_CrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {//崩溃捕捉
        [AlexExceptionManger handlerExceptionMessage:exception];
    }
    @finally {
        return object;
    }
}
//__NSArray0  objectAtIndex:
- (id)alex_NSArray0_CrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self alex_NSArray0_CrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {//崩溃捕捉
        [AlexExceptionManger handlerExceptionMessage:exception];
    }
    @finally {
        return object;
    }
}
//__NSArrayI  objectAtIndexedSubscript:
- (id)alex_NSArrayI_CrashObjectAtIndexedSubscript:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self alex_NSArrayI_CrashObjectAtIndexedSubscript:index];
    }
    @catch (NSException *exception) {//崩溃捕捉
        [AlexExceptionManger handlerExceptionMessage:exception];
    }
    @finally {
        return object;
    }
}

@end
