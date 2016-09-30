//
//  CommentListModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCommentListModel : NSObject

@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, strong) NSURL *head_img;
@property (nonatomic, copy) NSString *head_v_type;
@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *cl_id;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *to_user_id;
@property (nonatomic, copy) NSString *product_color;
@property (nonatomic, copy) NSString *product_size;
@property (nonatomic, strong) NSArray *img_list;
@property (nonatomic, strong) NSDictionary *to_user;
@property (nonatomic, strong) NSArray *subs;

@property (nonatomic, copy) NSString *cellIdentifier;

@end

@interface HCCommentListSubsModel : NSObject

@property (nonatomic, copy) NSString *nick_name;
//@property (nonatomic, copy) NSString *cl_id;
@property (nonatomic, copy) NSString *parent_id;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *create_time;

@end