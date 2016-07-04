//
//  MagazineInfoViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MagazineInfoViewCell.h"
#import "Masonry.h"
#import "MagazineInfoView.h"

@implementation MagazineInfoViewCell
{
    MagazineInfoView *_magazineInfoView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _magazineInfoView = ({
            MagazineInfoView *view = [MagazineInfoView new];
            [self.contentView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
            
            view;
        });
    }
    return self;
}

@end
