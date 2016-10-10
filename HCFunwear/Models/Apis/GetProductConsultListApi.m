//
//  getProductConsultListApi.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "getProductConsultListApi.h"
#import "GlobalContext.h"

@implementation GetProductConsultListApi

- (instancetype)initWithCode:(NSString *)code {
    self = [super init];
    if (self) {
        _code = code;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"cid":[GlobalContext ShareInstance].cid,
             @"a": @"getProductConsultList",
             @"m": @"Product",
             @"token":@"",
             @"code":self.code
             };
}

@end
