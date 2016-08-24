//
//  HCGetCollocationListByUserTypeApi.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "YTKRequest.h"

@interface HCGetCollocationListByUserTypeApi : YTKRequest

@property (nonatomic, assign) NSInteger pageIndex;

- (instancetype)initWithPageIndex:(NSInteger)index;

@end
