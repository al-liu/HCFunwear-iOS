//
//  GetRecommedProductListApi.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/18.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "YTKRequest.h"

@interface GetRecommedProductListApi : YTKRequest

- (instancetype)initWithPage:(NSInteger)page;

@property (nonatomic, assign) NSInteger page;

@end
