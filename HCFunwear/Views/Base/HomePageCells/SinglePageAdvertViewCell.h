//
//  SinglePageAdvertViewCell.h
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCHomeModuleCellProtocol.h"

@interface SinglePageAdvertViewCell : UICollectionViewCell <HCHomeModuleCellProtocol>

@property (nonatomic, strong) UIImageView *advertView;

@end
