//
//  GetAppBrandListApi.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "YTKRequest.h"

@interface GetAppBrandListApi : YTKRequest

- (instancetype)initWithPageIndex:(NSInteger)index pageSize:(NSInteger)size;
- (instancetype)initWithPageIndex:(NSInteger)index;

@property (nonatomic, assign) NSInteger pageIndex;
//默认：30
@property (nonatomic, assign) NSInteger pageSize;

@end
