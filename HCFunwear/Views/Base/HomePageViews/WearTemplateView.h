//
//  WearTemplateView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageHeadTitleView.h"

@interface WearTemplateView : UIView <UICollectionViewDataSource,UICollectionViewDelegate>
{
    HomePageHeadTitleView *_headTitleView;
}

@property (nonatomic, strong) UIImageView *modelImageView;
@property (nonatomic, strong) HomePageHeadTitleView *headTitleView;
@property (nonatomic, strong) HCModule *module;

- (void)reloadData;

@end
