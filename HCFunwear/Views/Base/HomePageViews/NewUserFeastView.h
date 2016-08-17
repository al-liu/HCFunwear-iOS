//
//  NewUserFeastView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/1.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCModule.h"

@interface NewUserFeastView : UIView <UICollectionViewDataSource,UICollectionViewDelegate>

//@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) UIImageView *feastImageView; 
@property (nonatomic, strong) HCModule *userFeastModule;
- (void)reloadData;

@end
