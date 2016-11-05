//
//  BrandBorderCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "BrandBorderCell.h"
#import "GlobalColors.h"

@implementation BrandBorderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth = .5f;
    self.layer.borderColor = kCellLineColor.CGColor;
}

@end
