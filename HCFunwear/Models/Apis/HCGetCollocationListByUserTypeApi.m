//
//  HCGetCollocationListByUserTypeApi.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCGetCollocationListByUserTypeApi.h"

@implementation HCGetCollocationListByUserTypeApi

- (instancetype)initWithPageIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        _pageIndex = index;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"a": @"getCollocationListByUserType",
             @"m": @"Collocation",
             @"page":@(_pageIndex),
             @"token":@"",
             @"userId":@"",
             };
}

@end
