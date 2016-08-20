//
//  HCBrand.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCBrand.h"

@implementation HCBrand

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _img = [NSURL URLWithString:dic[@"img"]];
    _web_url = [NSURL URLWithString:dic[@"web_url"]];
    _logo_img = [NSURL URLWithString:dic[@"logo_img"]];
    return YES;
}

@end
