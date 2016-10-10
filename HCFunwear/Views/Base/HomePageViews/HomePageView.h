//
//  HomePageView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/16.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageViewModel.h"

@interface HomePageView : UIView

@property (nonatomic, strong) UICollectionView *homePageCollectionView;
@property (nonatomic, strong) HomePageViewModel *homePageViewModel;

- (instancetype)initWithViewModel:(HomePageViewModel *)mdoel;

- (void)beginRefresh;

@end
