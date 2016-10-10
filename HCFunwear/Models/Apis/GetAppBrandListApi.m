//
//  GetAppBrandListApi.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "GetAppBrandListApi.h"
#import "GlobalContext.h"

@implementation GetAppBrandListApi

- (instancetype)initWithPageIndex:(NSInteger)index pageSize:(NSInteger)size {
    self = [super init];
    if (self) {
        _pageIndex = index;
        _pageSize = size;
    }
    return self;
}

- (instancetype)initWithPageIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        _pageIndex = index;
        _pageSize = 30;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _pageSize = 30;
        _pageIndex = 0;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"cid":[GlobalContext ShareInstance].cid,
             @"a": @"getAppBrandList",
             @"m": @"BrandMb",
             @"pageIndex":@(_pageIndex),
             @"pageSize":@(_pageSize),
             @"token":@""
             };
}

@end
