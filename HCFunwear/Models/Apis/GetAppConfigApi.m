//
//  GetAppConfigApi.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/10.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "GetAppConfigApi.h"
#import "GlobalContext.h"

@implementation GetAppConfigApi

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (NSString *)requestUrl {
    return @"http://mbfun.funwear.com/mbfun_config_server/index.php";
}

- (id)requestArgument {
    UIDevice *device = [UIDevice currentDevice];
    NSString *idfa = device.identifierForVendor.UUIDString;
    
    NSString *deviceId = device.identifierForVendor.UUIDString;
    NSString *osName = device.systemName;
    NSString *osVersion = device.systemVersion;
    NSDictionary *arguments = @{@"_platform":@"1",
                                @"appName":@"youfanguanfang",
                                @"cid":[GlobalContext ShareInstance].cid,
                                @"deviceId":deviceId,
                                @"osCode":@"ios",
                                @"osName":osName,
                                @"osVersion":osVersion,
                                @"idfa":idfa,
                                @"a": @"getAppConfig",
                                @"m": @"Config",
                                @"token":@"",
                                @"type":@"1"};
    return arguments;
}


@end
