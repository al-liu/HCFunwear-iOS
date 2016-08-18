//
//  HCProduct.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/18.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCProductTag.h"

@interface HCProduct : NSObject

@property (nonatomic, copy) NSString *product_sys_code;
@property (nonatomic, copy) NSString *market_price;
@property (nonatomic, strong) NSURL *product_url;
@property (nonatomic, copy) NSString *brand_id;
@property (nonatomic, copy) NSString *product_name;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *on_sale_date;
@property (nonatomic, copy) NSArray *spec_price_list;
@property (nonatomic, strong) NSURL *brandUrl;
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString *activity_rule;
@property (nonatomic, copy) NSString *activity_icon;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *stock_num;
@property (nonatomic, strong) NSArray *prodClsTag;

@end
