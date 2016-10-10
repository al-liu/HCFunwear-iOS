//
//  getCommentList.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "getCommentListApi.h"
#import "GlobalContext.h"

@implementation GetCommentListApi

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
             @"cid":[GlobalContext ShareInstance].cid,
             @"a": @"getCommentList",
             @"m": @"Comment",
             @"type":@"2",
             @"tid":self.code,
             @"page":@(self.page)
             };
}

@end
