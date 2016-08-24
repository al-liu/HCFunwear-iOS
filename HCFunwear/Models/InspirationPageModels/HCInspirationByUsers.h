//
//  HCInspirationByUsers.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCInspirationByUsers : NSObject

@property (nonatomic, copy) NSString *info_id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *content_info;
@property (nonatomic, strong) NSURL *img;
@property (nonatomic, copy) NSString *img_width;
@property (nonatomic, copy) NSString *img_height;
@property (nonatomic, strong) NSURL *stick_img_url;
@property (nonatomic, strong) NSURL *video_url;
@property (nonatomic, strong) NSArray *tag_list;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *mbfun_id;
@property (nonatomic, copy) NSString *mbfun_code;
@property (nonatomic, strong) NSURL *head_img;
@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *head_v_type;
@property (nonatomic, copy) NSString *item_str;
@property (nonatomic, copy) NSString *is_love;
@property (nonatomic, copy) NSString *like_count;
@property (nonatomic, copy) NSString *comment_count;

@end
