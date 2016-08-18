//
//  HCProductTag.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/18.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCProductTag : NSObject

@property (nonatomic, copy) NSString *tagName;
@property (nonatomic, strong) NSURL *tagUrl;
@property (nonatomic, copy) NSString *tagType;
@property (nonatomic, copy) NSString *remark;

@end
