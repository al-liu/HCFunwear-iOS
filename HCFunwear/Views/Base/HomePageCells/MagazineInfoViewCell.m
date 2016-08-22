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
#import "HCModule.h"
#import "UICollectionViewCell+RACCommand.h"

@implementation MagazineInfoViewCell
{
    
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

- (void)bindData:(id)data {
    HCModule *module = data;
    _magazineInfoView.module = module;
    [_magazineInfoView reloadData];
}

- (void)bindPush:(RACCommand *)push {
    self.push = push;
}

@end
