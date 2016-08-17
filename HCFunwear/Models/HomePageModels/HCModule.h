//
//  HCModule.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/14.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCModuleData.h"

@interface HCModule : NSObject

@property (nonatomic, copy) NSString *module_id;
@property (nonatomic, copy) NSString *c_title;
@property (nonatomic, copy) NSString *e_title;
@property (nonatomic, copy) NSString *module_key;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, assign) BOOL is_more;
@property (nonatomic, copy) NSArray *data;

@end
