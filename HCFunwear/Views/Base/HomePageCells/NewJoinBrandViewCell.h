//
//  NewJoinBrandViewCell.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/5.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewJoinBrandView.h"
#import "HCHomeModuleCellProtocol.h"

@interface NewJoinBrandViewCell : UICollectionViewCell <HCHomeModuleCellProtocol>

@property (nonatomic, strong) NewJoinBrandView *joinBrandView;

@end
