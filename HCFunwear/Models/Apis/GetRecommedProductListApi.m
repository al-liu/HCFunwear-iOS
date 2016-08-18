//
//  GetRecommedProductListApi.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/18.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "GetRecommedProductListApi.h"

@implementation GetRecommedProductListApi

- (instancetype)init {
    self = [super init];
    if (self) {
        _page = 0;
    }
    return self;
}

- (instancetype)initWithPage:(NSInteger)page {
    self = [super init];
    if (self) {
        _page = page;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"a": @"getRecommedProductList",
             @"m": @"Product",
             @"page":@(_page),
             @"token":@""
             };
}

@end
