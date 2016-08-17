//
//  HCModule.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/14.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCModule.h"

@implementation HCModule

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"module_id":@"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : HCModuleData.class};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _is_more = ([dic[@"is_more"] isEqualToString:@"1"] ? YES : NO);
    return YES;
}

@end
