//
//  AlexExceptionManger.h
//  test
//
//  Created by 高莹莹 on 2019/4/16.
//  Copyright © 2019年 高莹莹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
#define CollectCrashNotification @"CollectCrashNotification"
#define CrashVersioniOS(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)
@interface AlexExceptionManger : NSObject
//获取 堆栈所有信息
+ (NSArray *)getStackSymbolsArr;

//处理崩溃信息，将崩溃信息格式化后收集
+ (void)handlerExceptionMessage:(NSException *)exception;
// 获取堆栈主要崩溃信息
+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols;
//将异常信息封装为字典
+ (NSDictionary *)getExceptionDicExceptionName:(NSString *)exceptionName
                               ExceptionReason:(NSString *)exceptionReason
                          ExceptionClassMethod:(NSString *)exceptionClassMethod;
@end

NS_ASSUME_NONNULL_END
