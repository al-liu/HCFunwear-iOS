//
//  MinePageViewModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/11.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MinePageViewModel.h"
#import "MineMenuModel.h"

@interface MinePageViewModel ()

@property (nonatomic, strong, readwrite) NSArray *mineMenuModels;
@property (nonatomic, strong, readwrite) NSArray *mineOrderMenuModels;

@end
@implementation MinePageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        MineMenuModel *menu01 = [[MineMenuModel alloc]initWithImage:@"ico_home_favor"
                                                              title:@"我的心愿单"];
        MineMenuModel *menu02 = [[MineMenuModel alloc]initWithImage:@"ico_collection"
                                                              title:@"我的收藏"];
        MineMenuModel *menu03 = [[MineMenuModel alloc]initWithImage:@"ico_footprint"
                                                              title:@"我的足迹"];
        _mineMenuModels = @[menu01,menu02,menu03];
        
        MineMenuModel *menu04 = [[MineMenuModel alloc]initWithImage:@"ico_fukuan"
                                                              title:@"待付款"];
        MineMenuModel *menu05 = [[MineMenuModel alloc]initWithImage:@"ico_fahuo"
                                                              title:@"待发货"];
        MineMenuModel *menu06 = [[MineMenuModel alloc]initWithImage:@"ico_shouhuo"
                                                              title:@"待收货"];
        MineMenuModel *menu07 = [[MineMenuModel alloc]initWithImage:@"ico_pingjia"
                                                              title:@"待评价"];
        MineMenuModel *menu08 = [[MineMenuModel alloc]initWithImage:@"ico_shouhou"
                                                              title:@"售后"];
        _mineOrderMenuModels = @[menu04,menu05,menu06,menu07,menu08];
    }
    return self;
}

@end
