//
//  HCGoodsDetailShowPictureView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/2.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface HCGoodsDetailShowPictureView : UIView <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *showPictureView;
@property (nonatomic, strong) UILabel *pageControlLabel;

@end
