//
//  getProductConsultListApi.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "YTKRequest.h"

@interface GetProductConsultListApi : YTKRequest

@property (nonatomic, copy)NSString *code;
- (instancetype)initWithCode:(NSString *)code;

@end
