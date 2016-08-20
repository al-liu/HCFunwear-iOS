//
//  HCBrand.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCBrand : NSObject

@property (nonatomic, copy) NSString *data_id;
@property (nonatomic, copy) NSString *brand_code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSURL *img;
@property (nonatomic, strong) NSURL *web_url;
@property (nonatomic, strong) NSURL *logo_img;
@property (nonatomic, copy) NSString *product_brand_img;
@property (nonatomic, copy) NSString *sort;

@end
