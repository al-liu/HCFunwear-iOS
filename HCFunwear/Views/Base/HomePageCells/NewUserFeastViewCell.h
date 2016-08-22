//
//  NewUserFeastViewCell.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewUserFeastView.h"
#import "HCHomeModuleCellProtocol.h"

@interface NewUserFeastViewCell : UICollectionViewCell <HCHomeModuleCellProtocol>

@property (nonatomic, strong) NewUserFeastView *feastView;

@end
