//
//  HCGridMenuViewCell.h
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCGridMenuView.h"
#import "HCHomeModuleCellProtocol.h"

@interface HCGridMenuViewCell : UICollectionViewCell <HCHomeModuleCellProtocol,HCGridMenuViewProtocol>

@property (nonatomic, strong) HCGridMenuView *gridMenuView;

@end
