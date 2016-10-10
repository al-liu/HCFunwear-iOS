//
//  GetCategoryListApi.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "GetCategoryListApi.h"
#import "GlobalContext.h"

@implementation GetCategoryListApi

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"cid":[GlobalContext ShareInstance].cid,
             @"a": @"getCategoryList",
             @"m": @"Category",
             @"token":@""
             };
}

@end
