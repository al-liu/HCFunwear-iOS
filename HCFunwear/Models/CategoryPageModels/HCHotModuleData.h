//
//  HCHotModuleData.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCJump.h"

@interface HCHotModuleData : NSObject

@property (nonatomic, copy) NSString *data_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *jump_id;
@property (nonatomic, copy) NSString *replace_param;
@property (nonatomic, copy) NSString *img_wap;
@property (nonatomic, strong) NSURL *img;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *is_delete;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *cate_id;
@property (nonatomic, copy) NSString *temp_id;
@property (nonatomic, copy) NSString *use_for;
@property (nonatomic, strong) NSURL *cate_img;
@property (nonatomic, strong) HCJump *jump;

@end
