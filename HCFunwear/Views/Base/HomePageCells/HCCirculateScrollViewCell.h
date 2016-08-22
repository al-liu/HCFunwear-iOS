//
//  HCCirculateScrollViewCell.h
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCCirculateScrollView.h"
#import "HCHomeModuleCellProtocol.h"

@interface HCCirculateScrollViewCell : UICollectionViewCell <HCHomeModuleCellProtocol,HCCirculateScrollViewProtocol>

@property (nonatomic, strong) HCCirculateScrollView *circulateScrollView;

@end
