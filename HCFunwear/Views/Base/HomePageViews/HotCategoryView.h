//
//  HotCategoryView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCModule.h"

@interface HotCategoryView : UIView <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) HCModule *hotCategoryModule;

- (void)reloadData;

@end
