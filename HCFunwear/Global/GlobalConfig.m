//
//  GlobalConfig.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/12.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "GlobalConfig.h"
#import "YTKNetworkConfig.h"
#import "YTKUrlArgumentsFilter.h"

@implementation GlobalConfig
- (void)configNetwork {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = @"http://api.funwear.com/mbfun_server/index.php";
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *deviceId = device.identifierForVendor.UUIDString;
    NSString *osName = device.systemName;
    NSString *osVersion = device.systemVersion;
    NSDictionary *arguments = @{@"_platform":@"1",
                                @"appName":@"youfanguanfang",
                                @"cid":@"2",
                                @"deviceId":deviceId,
                                @"osCode":@"ios",
                                @"osName":osName,
                                @"osVersion":osVersion};
    YTKUrlArgumentsFilter *urlFilter = [YTKUrlArgumentsFilter filterWithArguments:arguments];
    [config addUrlFilter:urlFilter];
}
@end
