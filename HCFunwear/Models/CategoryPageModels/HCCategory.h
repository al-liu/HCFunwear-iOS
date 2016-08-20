//
//  HCCategory.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCategory : NSObject

@property (nonatomic, copy) NSString *cate_id;
@property (nonatomic, copy) NSString *parent_id;
@property (nonatomic, copy) NSString *cate_name;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, strong) NSURL *img;
@property (nonatomic, strong) NSArray *subs;

@end
