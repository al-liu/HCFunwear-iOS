//
//  CommentListModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCCommentListModel.h"

@implementation HCCommentListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cl_id":@"id"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _head_img = [NSURL URLWithString:dic[@"head_img"]];
    
    return YES;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"subs" : HCCommentListSubsModel.class};
}

@end

@implementation HCCommentListSubsModel

@end