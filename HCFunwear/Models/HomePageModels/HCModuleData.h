//
//  HCModuleData.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/14.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCJump.h"

@interface HCModuleData : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *jump_id;
@property (nonatomic, copy) NSString *replace_param;
@property (nonatomic, strong) NSURL *img;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *module_id;
@property (nonatomic, copy) NSString *price_tag;
@property (nonatomic, copy) NSString *product_price;
@property (nonatomic, strong) HCJump *jump;

@end
