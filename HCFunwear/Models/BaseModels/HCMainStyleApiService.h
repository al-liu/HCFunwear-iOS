//
//  HCMainStyleApiService.h
//  HCFunwear
//
//  Created by 刘海川 on 16/10/10.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@protocol HCMainStyleApiService <NSObject>

- (RACSignal *)getAppConfig;

@end
