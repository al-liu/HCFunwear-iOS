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
#import "YYFPSLabel.h"
#import "AppDelegate.h"
#import "CocoaLumberjack.h"
#import "GlobalContext.h"

@implementation GlobalConfig
- (void)configDefaultNetworkParameters {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = @"http://api.funwear.com/mbfun_server/index.php";
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *deviceId = device.identifierForVendor.UUIDString;
    NSString *osName = device.systemName;
    NSString *osVersion = device.systemVersion;
    NSDictionary *arguments = @{@"_platform":@"1",
                                @"appName":@"youfanguanfang",
                                @"deviceId":deviceId,
                                @"osCode":@"ios",
                                @"osName":osName,
                                @"osVersion":osVersion};
    YTKUrlArgumentsFilter *urlFilter = [YTKUrlArgumentsFilter filterWithArguments:arguments];
    [config addUrlFilter:urlFilter];
}

- (void)alterNetworkPublicParameters:(NSDictionary *)parameters {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    NSArray *filters = config.urlFilters;
    __block BOOL isAlter = NO;
    [filters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:YTKUrlArgumentsFilter.class]) {
            YTKUrlArgumentsFilter *urlFilter = obj;
            [urlFilter alterAugumentsWithDict:parameters];
            isAlter = YES;
        }
    }];
    NSAssert(isAlter, @"YTKNetworkConfig's urlFilters has't YTKUrlArgumentsFilter");
}

- (void)configLog {
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
}

@end
