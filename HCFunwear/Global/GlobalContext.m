//
//  GlobalContext.m
//  HCFunwear
//
//  Created by 刘海川 on 16/5/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "GlobalContext.h"

static GlobalContext *globalContext = nil;

@implementation GlobalContext

+ (instancetype)ShareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalContext = [[GlobalContext alloc]init];
    });
    return globalContext;
}

@end
