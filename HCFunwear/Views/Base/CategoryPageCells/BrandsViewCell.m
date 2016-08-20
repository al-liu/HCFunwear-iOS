//
//  BrandsViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "BrandsViewCell.h"
#import "Masonry.h"

@implementation BrandsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor colorWithWhite:0.937 alpha:1.000];
    [self.contentView addSubview:bottomLine];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@.5);
        make.left.right.bottom.equalTo(self.contentView);
    }];
    
    UIView *rightLine = [UIView new];
    rightLine.backgroundColor = [UIColor colorWithWhite:0.937 alpha:1.000];
    [self.contentView addSubview:rightLine];
    
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@.5);
        make.right.top.bottom.equalTo(self.contentView);
    }];
}

@end
