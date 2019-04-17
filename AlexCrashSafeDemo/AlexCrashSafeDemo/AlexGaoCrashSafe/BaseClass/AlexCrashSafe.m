//
//  AlexCrashSafe.m
//  AlexCrashSafeDemo
//
//  Created by 高莹莹 on 2019/4/17.
//  Copyright © 2019年 高莹莹. All rights reserved.
//

#import "AlexCrashSafe.h"
#import "NSArray+AlexArrayCrash.h"
#import "NSMutableArray+AlexMutableArrayCrash.h"
#import "NSMutableDictionary+AlexMtableDictonnaryCrash.h"
#import "NSObject+AlexNSObjectCrash.h"
@implementation AlexCrashSafe
+ (void)openAlexCrashSafe
{
    [NSArray arrExchangeCrashMethod];
    [NSMutableArray mutableArrExchangeCrashMethod];
    [NSMutableDictionary mutableDicExchangeCrashMethod];
    [NSObject objectExchangeMethodOpenNoneSel:YES];
}
@end
