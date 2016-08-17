//
//  HCModuleData.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/14.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCModuleData.h"

@implementation HCModuleData

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _img = [NSURL URLWithString:dic[@"img"]];
    return YES;
}

@end
