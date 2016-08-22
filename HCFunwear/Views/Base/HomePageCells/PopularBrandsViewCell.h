//
//  PopularBrandsViewCell.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopularBrandsView.h"
#import "HCHomeModuleCellProtocol.h"

@interface PopularBrandsViewCell : UICollectionViewCell <HCHomeModuleCellProtocol>

@property (nonatomic, strong) PopularBrandsView *brandsView;

@end
