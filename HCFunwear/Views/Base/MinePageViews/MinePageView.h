//
//  MinePageView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/12.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinePageView : UIView <UICollectionViewDataSource,UICollectionViewDelegate>

//菜单 我的心愿单..
@property (nonatomic, strong) NSArray *minePageMenus;
//菜单 我的订单
@property (nonatomic, strong) NSArray *minePageOrderMenus;

- (void)reloadData;

@end
