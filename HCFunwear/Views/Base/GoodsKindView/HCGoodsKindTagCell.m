//
//  HCGoodsKindTagCell.m
//  GoodsStyleView
//
//  Created by 刘海川 on 16/10/25.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCGoodsKindTagCell.h"

@implementation HCGoodsKindTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.layer.borderWidth = .5f;
    self.contentView.layer.borderColor = [UIColor grayColor].CGColor;
    
    UIView *selectedBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame))];
    selectedBackgroundView.layer.borderWidth = 2;
    selectedBackgroundView.layer.borderColor = [UIColor blackColor].CGColor;
    self.selectedBackgroundView = selectedBackgroundView;
    
}

@end
