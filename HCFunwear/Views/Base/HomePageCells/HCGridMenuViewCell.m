//
//  HCGridMenuViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCGridMenuViewCell.h"
#import "Masonry.h"

@implementation HCGridMenuViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _gridMenuView = [HCGridMenuView new];
        [self.contentView addSubview:_gridMenuView];
        
        [_gridMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        _gridMenuView.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

@end
