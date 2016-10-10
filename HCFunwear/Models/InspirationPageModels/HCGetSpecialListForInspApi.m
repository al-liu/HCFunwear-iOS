//
//  HCGetSpecialListForInspApi.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCGetSpecialListForInspApi.h"
#import "GlobalContext.h"

@implementation HCGetSpecialListForInspApi

- (instancetype)initWithPageIndex:(NSInteger)index
                             size:(NSInteger)size
                           typeId:(NSString *)aid {
    self = [super init];
    if (self) {
        _pageIndex = index;
        _pageSize = size;
        _typeId = aid;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"cid":[GlobalContext ShareInstance].cid,
             @"a": @"getSpecialListForInsp",
             @"m": @"Special",
             @"pageIndex":@(_pageIndex),
             @"PageSize":@(_pageSize),
             @"token":@"",
             @"aid":_typeId
             };
}

@end
