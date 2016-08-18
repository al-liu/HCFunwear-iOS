//
//  HCProduct.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/18.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCProduct.h"

@implementation HCProduct

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _product_url = [NSURL URLWithString:dic[@"product_url"]];
    _brandUrl = [NSURL URLWithString:dic[@"brandUrl"]];
    
    return YES;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"prodClsTag" : HCProductTag.class};
}


@end
