//
//  AppConfigModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/10.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "AppConfigModel.h"
#import "NSObject+YYModel.h"

@implementation AppConfigModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *json = dic[@"LAUNCH_BANNER"];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    
    NSAssert(error == nil, @"NSJSONSerialization Error");
    _launchBanner = [LaunchBanner modelWithJSON:dict[@"banner"]];
    
    return YES;
}

@end

@implementation LaunchBanner

@end
