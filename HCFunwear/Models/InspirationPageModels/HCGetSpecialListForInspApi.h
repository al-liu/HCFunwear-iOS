//
//  HCGetSpecialListForInspApi.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//


#import "YTKRequest.h"

@interface HCGetSpecialListForInspApi : YTKRequest

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, copy) NSString *typeId;

- (instancetype)initWithPageIndex:(NSInteger)index
                             size:(NSInteger)size
                           typeId:(NSString *)aid;

@end
