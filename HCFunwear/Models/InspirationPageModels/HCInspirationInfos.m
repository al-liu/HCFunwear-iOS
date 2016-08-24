//
//  HCInspirationInfos.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCInspirationInfos.h"

@implementation HCInfoTab

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"tab_id":@"id"};
}

@end

@implementation HCInspInfo

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"info_id":@"id"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _img = [NSURL URLWithString:dic[@"img"]];
    _url = [NSURL URLWithString:dic[@"url"]];
    return YES;
}

@end

@implementation HCInspirationInfos

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"attr" : HCInfoTab.class,@"list" : HCInspInfo.class};
}

@end
