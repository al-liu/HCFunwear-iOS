//
//  HCProductDetailModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCProductDetailModel.h"

@implementation HCProductDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"proPicUrl" : HCPicUrl.class,
             @"clsPicUrl" : HCPicUrl.class,
             @"activity" : HCActivity.class,
             @"addPicUrl" : HCAddPicUrl.class};
}

@end

@implementation HCClsInfo

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"clsDescription":@"description"};
}

@end

@implementation HCPicUrl

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _filE_PATH = [NSURL URLWithString:dic[@"filE_PATH"]];

    return YES;
}

@end

@implementation HCActivity

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _url = [NSURL URLWithString:dic[@"url"]];
    
    return YES;
}

@end

@implementation HCAddPicUrl

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _image_url = [NSURL URLWithString:dic[@"image_url"]];
    
    return YES;
}

@end

@implementation HCBrandDispatchGoods

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _img = [NSURL URLWithString:dic[@"img"]];
    _url = [NSURL URLWithString:dic[@"url"]];
    
    return YES;
}

@end

