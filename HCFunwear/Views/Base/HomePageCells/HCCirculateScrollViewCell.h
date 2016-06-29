//
//  HCCirculateScrollViewCell.h
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCCirculateScrollView.h"

@interface HCCirculateScrollViewCell : UICollectionViewCell

@property (nonatomic, strong) HCCirculateScrollView *circulateScrollView;
@property (nonatomic, weak) id cellDelegate;

@end
