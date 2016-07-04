//
//  WearTemplateViewCell.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WearTemplateView.h"

@interface WearTemplateViewCell : UICollectionViewCell {
    WearTemplateView *_wearTemplateView;
}

@property (nonatomic, strong) WearTemplateView *wearTemplateView;

@end
