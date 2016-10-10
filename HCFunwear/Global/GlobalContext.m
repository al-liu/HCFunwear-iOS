//
//  GlobalContext.m
//  HCFunwear
//
//  Created by 刘海川 on 16/5/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "GlobalContext.h"
#import "GlobalConstant.h"

static GlobalContext *globalContext = nil;

@implementation GlobalContext

+ (instancetype)ShareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalContext = [[GlobalContext alloc]init];
        
        NSString *cidStr = [[NSUserDefaults standardUserDefaults] stringForKey:kCID];
        if (cidStr) {
            globalContext.cid = cidStr;
        }
        else {
            globalContext.cid = @"1";
        }
    });
    return globalContext;
}

- (void)setCid:(NSString *)cid {
    _cid = cid;
    
    [[NSUserDefaults standardUserDefaults] setObject:_cid forKey:kCID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
