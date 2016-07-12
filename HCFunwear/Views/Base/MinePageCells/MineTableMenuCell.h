//
//  MineTableMenuCell.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/12.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineTableMenuModel.h"

@interface MineTableMenuCell : UICollectionViewCell

@property (nonatomic, assign) BOOL isShowAwakePoint;
@property (nonatomic, assign) BOOL isShowSubTitle;
@property (nonatomic, assign) CGFloat lineLeadingConstant;

@property (nonatomic, strong) MineTableMenuModel *tableMenuModel;

@end
