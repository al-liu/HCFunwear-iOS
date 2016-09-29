//
//  getCommentList.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "getCommentListApi.h"

@implementation getCommentListApi

- (instancetype)initWithCode:(NSString *)code page:(NSInteger)index {
    self = [super init];
    if (self) {
        _code = code;
        _page = index;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"a": @"getCommentList",
             @"m": @"Comment",
             @"tid":self.code,
             @"page":@(self.page)
             };
}

@end
