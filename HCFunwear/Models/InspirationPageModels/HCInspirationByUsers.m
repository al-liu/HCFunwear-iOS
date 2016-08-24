//
//  HCInspirationByUsers.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCInspirationByUsers.h"

@implementation HCInspirationByUsers

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"info_id":@"id"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _img = [NSURL URLWithString:dic[@"img"]];
    _stick_img_url = [NSURL URLWithString:dic[@"stick_img_url"]];
    _video_url = [NSURL URLWithString:dic[@"video_url"]];
    _head_img = [NSURL URLWithString:dic[@"head_img"]];
    return YES;
}

@end
