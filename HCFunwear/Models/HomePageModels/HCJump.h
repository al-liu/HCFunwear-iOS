//
//  HCJump.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/14.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HCJumpExtension : NSObject

@property (nonatomic, strong) NSURL *headImageURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *jump_cid;
@property (nonatomic, strong) NSURL *img;

@end

@interface HCJump : NSObject

@property (nonatomic, copy) NSString *jumpId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) NSString *jump_type;
@property (nonatomic, strong) HCJumpExtension *ext;

@end
