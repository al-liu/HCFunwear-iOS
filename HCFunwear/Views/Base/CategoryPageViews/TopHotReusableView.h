//
//  TopHotReusableView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCCirculateScrollView.h"

@interface TopHotReusableView : UICollectionReusableView <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) HCCirculateScrollView *circulateScrollView;

- (void)reloadHotBrandsWithDatas:(NSArray *)datas;

@end
