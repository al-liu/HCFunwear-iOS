//
//  HomePageViewModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HomePageViewModel.h"
#import "HCGridMenuView.h"
#import "HomePageHeadTitleView.h"

@implementation HomePageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        //菜单临时数据
        UIImage *defaultImage = [UIImage imageNamed:@"fan_default_03"];
        HCGridInfo *grid01 = [[HCGridInfo alloc]initWithIcon:defaultImage title:@"今日新品"];
        HCGridInfo *grid02 = [[HCGridInfo alloc]initWithIcon:defaultImage title:@"热卖品类"];
        HCGridInfo *grid03 = [[HCGridInfo alloc]initWithIcon:defaultImage title:@"美妆馆"];
        HCGridInfo *grid04 = [[HCGridInfo alloc]initWithIcon:defaultImage title:@"人气单品"];
        HCGridInfo *grid05 = [[HCGridInfo alloc]initWithIcon:defaultImage title:@"韩风馆"];
        HCGridInfo *grid06 = [[HCGridInfo alloc]initWithIcon:defaultImage title:@"流行资讯"];
        HCGridInfo *grid07 = [[HCGridInfo alloc]initWithIcon:defaultImage title:@"Funshion"];
        HCGridInfo *grid08 = [[HCGridInfo alloc]initWithIcon:defaultImage title:@"限时闪购"];
        _gridMenuArray = @[grid01,grid02,grid03,grid04,grid05,grid06,grid07,grid08];
        
        //部分 head title
        HeadTitleModel *head01 = [[HeadTitleModel alloc]initWithTitle:@"上装" englishTitle:@"Tops" isShowMore:YES];
        HeadTitleModel *head02 = [[HeadTitleModel alloc]initWithTitle:@"下装" englishTitle:@"Bottoms" isShowMore:YES];
        HeadTitleModel *head03 = [[HeadTitleModel alloc]initWithTitle:@"鞋履" englishTitle:@"Shoes" isShowMore:YES];
        HeadTitleModel *head04 = [[HeadTitleModel alloc]initWithTitle:@"包袋" englishTitle:@"Bags" isShowMore:YES];
        HeadTitleModel *head05 = [[HeadTitleModel alloc]initWithTitle:@"配饰" englishTitle:@"Accessories" isShowMore:YES];
        HeadTitleModel *head06 = [[HeadTitleModel alloc]initWithTitle:@"男士护理" englishTitle:@"Grooming" isShowMore:YES];
        HeadTitleModel *head07 = [[HeadTitleModel alloc]initWithTitle:@"户外运动" englishTitle:@"outdoor sports" isShowMore:YES];
        _headTitleArray = @[head01,head02,head03,head04,head05,head06,head07];
    }
    return self;
}

//临时数据


#pragma mark - 交易
// 可能要讲交易组合起来

@end
