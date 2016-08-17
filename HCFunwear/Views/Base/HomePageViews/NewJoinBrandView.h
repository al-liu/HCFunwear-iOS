//
//  NewJoinBrandView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCModule.h"

@interface NewJoinBrandView : UIView <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIImageView *modelImageView;;
@property (nonatomic, strong) HCModule *module;
- (void)reloadData;

@end
