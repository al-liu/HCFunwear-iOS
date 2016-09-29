//
//  getCommentList.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "YTKRequest.h"

@interface getCommentListApi : YTKRequest

@property (nonatomic, copy)NSString *code;
@property (nonatomic, assign) NSInteger page;
- (instancetype)initWithCode:(NSString *)code page:(NSInteger)index;

@end
