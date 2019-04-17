//
//  NSObject+AlexNSObjectCrash.h
//  test
//
//  Created by 高莹莹 on 2019/4/17.
//  Copyright © 2019年 高莹莹. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AlexNSObjectCrash)
+ (void)objectExchangeMethodOpenNoneSel:(BOOL)ifDealWithNoneSel;
@end

NS_ASSUME_NONNULL_END
