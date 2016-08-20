//
//  GetCategoryListApi.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "GetCategoryListApi.h"

@implementation GetCategoryListApi

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"a": @"getCategoryList",
             @"m": @"Category",
             @"token":@""
             };
}

@end
