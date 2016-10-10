//
//  CategroyLayoutApi.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "CategroyLayoutApi.h"
#import "GlobalContext.h"

@implementation CategroyLayoutApi

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"cid":[GlobalContext ShareInstance].cid,
             @"a": @"getAppHotLayout",
             @"m": @"Home",
             @"token":@""
             };
}

- (NSInteger)cacheTimeInSeconds {
    return 5;
}

@end
