//
//  HCInspInfoModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCInspInfoModel : NSObject

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, copy) NSString *infoAid;

@property (nonatomic, strong) NSMutableArray *tableInfosList;

- (instancetype)initWithAID:(NSString *)aid;

@end
