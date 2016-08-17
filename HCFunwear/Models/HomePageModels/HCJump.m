//
//  HCJump.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/14.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCJump.h"

@implementation HCJumpExtension

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _img = [NSURL URLWithString:dic[@"img"]];
    _headImageURL = [NSURL URLWithString:dic[@"headImageURL"]];
    return YES;
}

@end

@implementation HCJump

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"jumpId":@"id"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _url = [NSURL URLWithString:dic[@"url"]];
    return YES;
}

@end
