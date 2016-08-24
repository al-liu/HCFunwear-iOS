//
//  HCInspInfoModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCInspInfoModel.h"

@implementation HCInspInfoModel

- (instancetype)initWithAID:(NSString *)aid {
    self = [super init];
    if (self) {
        _pageIndex = 1;
        _pageSize = 10;
        _infoAid = aid;
        _tableInfosList = [NSMutableArray array];
    }
    return self;
}

@end
