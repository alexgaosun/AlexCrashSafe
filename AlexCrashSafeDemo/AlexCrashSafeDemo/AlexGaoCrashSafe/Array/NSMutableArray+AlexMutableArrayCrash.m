//
//  NSMutableArray+AlexMutableArrayCrash.m
//  test
//
//  Created by 高莹莹 on 2019/4/17.
//  Copyright © 2019年 高莹莹. All rights reserved.
//

#import "NSMutableArray+AlexMutableArrayCrash.h"
#import "NSObject+Swizzling.h"
#import "AlexExceptionManger.h"
@implementation NSMutableArray (AlexMutableArrayCrash)
+ (void)mutableArrExchangeCrashMethod{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSArrayM = NSClassFromString(@"__NSArrayM");//可变数组
        [NSMutableArray exchangeInstanceMethod:__NSArrayM oldMethodSel:@selector(objectAtIndex:) newMethodSel:@selector(alex_NSArrayM_CrashObjectAtIndex:)];

        if (CrashVersioniOS(11.0)) {
            [NSMutableArray exchangeInstanceMethod:__NSArrayM oldMethodSel:@selector(objectAtIndexedSubscript:) newMethodSel:@selector(alex_NSArrayM_CrashObjectAtIndexedSubscript:)];
        }
        
        //insertObject:atIndex:
        [NSMutableArray exchangeInstanceMethod:__NSArrayM oldMethodSel:@selector(insertObject:atIndex:) newMethodSel:@selector(alex_NSArrayM_CrashInsertObject:atIndex:)];
        //insertObject:atIndex:
        [NSMutableArray exchangeInstanceMethod:__NSArrayM oldMethodSel:@selector(removeObjectAtIndex:) newMethodSel:@selector(alex_NSArrayM_CrashRemoveObjectAtIndex:)];
    });
}
//__NSArrayM  objectAtIndex:
- (id)alex_NSArrayM_CrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self alex_NSArrayM_CrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {//崩溃捕捉
        [AlexExceptionManger handlerExceptionMessage:exception];
    }
    @finally {
        return object;
    }
}
//__NSArrayM  objectAtIndexedSubscript:
- (id)alex_NSArrayM_CrashObjectAtIndexedSubscript:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self alex_NSArrayM_CrashObjectAtIndexedSubscript:index];
    }
    @catch (NSException *exception) {//崩溃捕捉
        [AlexExceptionManger handlerExceptionMessage:exception];
    }
    @finally {
        return object;
    }
}

//__NSArrayM  insertObject:atIndex:
- (void)alex_NSArrayM_CrashInsertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self alex_NSArrayM_CrashInsertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        [AlexExceptionManger handlerExceptionMessage:exception];
    }
    @finally {
        
    }
}

//__NSArrayM  removeObjectAtIndex:
- (void)alex_NSArrayM_CrashRemoveObjectAtIndex:(NSUInteger)index {
    @try {
        [self alex_NSArrayM_CrashRemoveObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [AlexExceptionManger handlerExceptionMessage:exception];
    }
    @finally {
        
    }
}

@end
