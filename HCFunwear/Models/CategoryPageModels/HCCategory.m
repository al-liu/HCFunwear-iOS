//
//  HCCategory.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCCategory.h"

@implementation HCCategory

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cate_id":@"id"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _img = [NSURL URLWithString:dic[@"img"]];
    return YES;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"subs" : HCCategory.class};
}

@end
