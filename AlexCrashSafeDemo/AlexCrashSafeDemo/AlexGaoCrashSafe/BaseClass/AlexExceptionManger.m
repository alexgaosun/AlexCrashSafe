//
//  AlexExceptionManger.m
//  test
//
//  Created by 高莹莹 on 2019/4/16.
//  Copyright © 2019年 高莹莹. All rights reserved.
//

#import "AlexExceptionManger.h"
#define key_exceptionName    @"key_Name"
#define key_exceptionReason  @"key_Reason"
#define key_exceptionClassMethod  @"key_ClassMethod"
@implementation AlexExceptionManger
+ (NSArray *)getStackSymbolsArr
{
    //堆栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    return callStackSymbolsArr;
}

+ (void)handlerExceptionMessage:(NSException *)exception
{
    NSArray *callStackSymbolsArr = [exception callStackSymbols];
    NSString *errorName = exception.name;
    NSString *errorReason = exception.reason;
    NSString *classMethodstr = [AlexExceptionManger getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbolsArr];
    if (!classMethodstr) {
        classMethodstr = @"method cannot locate----Please check key_Reason";
    }
    NSDictionary *exceptionDic = [AlexExceptionManger getExceptionDicExceptionName:errorName ExceptionReason:errorReason ExceptionClassMethod:classMethodstr];
    //将错误信息放在字典里，用通知的形式发送出去
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:CollectCrashNotification object:nil userInfo:exceptionDic];
    });
}

/**
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *
 *  @param callStackSymbols 堆栈主要崩溃信息
 *
 *  @return 堆栈主要崩溃精简化的信息
 */

+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols {
    
    //mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    
    for (int index = 0; index < callStackSymbols.count; index++) {
        NSString *callStackSymbol = callStackSymbols[index];
        
        [regularExp enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString* tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
                
                //get className
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;
                
                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                
                //filter category and system class
                if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                    mainCallStackSymbolMsg = tempCallStackSymbolMsg;
                    
                }
                *stop = YES;
            }
        }];
        
        if (mainCallStackSymbolMsg.length) {
            break;
        }
    }
    
    return mainCallStackSymbolMsg;
}

+ (NSDictionary *)getExceptionDicExceptionName:(NSString *)exceptionName
                               ExceptionReason:(NSString *)exceptionReason
                          ExceptionClassMethod:(NSString *)exceptionClassMethod

{
    NSDictionary *exceptionDic = @{key_exceptionName:exceptionName,
                                   key_exceptionReason:exceptionReason,
                                   key_exceptionClassMethod:exceptionClassMethod};
    NSLog(@"==========crashCatchDic==========\n%@\n     ==========End==========",exceptionDic);
    return exceptionDic;
}


@end
