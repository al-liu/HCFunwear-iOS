//
//  ProductFilterApi.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ProductFilterApi.h"
#import "GlobalContext.h"

@implementation ProductFilterApi

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
             @"a": @"ProductFilter",
             @"m": @"ProductFilter",
             @"token":@"",
             @"prodClsIdList":self.code
             };
}

@end
