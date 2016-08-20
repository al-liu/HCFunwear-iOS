//
//  HCHotModule.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCHotModule.h"
#import "HCHotModuleData.h"

@implementation HCHotModule

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"module_id":@"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : HCHotModuleData.class};
}

@end
