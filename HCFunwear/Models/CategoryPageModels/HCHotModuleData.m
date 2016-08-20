//
//  HCHotModuleData.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCHotModuleData.h"

@implementation HCHotModuleData

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"data_id":@"id"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _img = [NSURL URLWithString:dic[@"img"]];
    _cate_img = [NSURL URLWithString:dic[@"cate_img"]];
    return YES;
}


@end
