//
//  getProductDetailsApi.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "getProductDetailsApi.h"

@implementation GetProductDetailsApi

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
             @"a": @"getProductDetails",
             @"m": @"Product",
             @"token":@"",
             @"code":self.code
             };
}

@end
