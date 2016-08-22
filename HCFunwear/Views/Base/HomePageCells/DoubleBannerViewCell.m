//
//  DoubleBannerViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "DoubleBannerViewCell.h"
#import "Masonry.h"
#import "DoubleBannerView.h"
#import "GlobalColors.h"
#import "HCModule.h"
#import "UICollectionViewCell+RACCommand.h"

@implementation DoubleBannerViewCell
{
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _doubleBannerView = ({
            DoubleBannerView *view = [DoubleBannerView new];
            [self.contentView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
            
            view;
        });
        self.backgroundColor = kCommonColor;
    }
    return self;
}

- (void)bindData:(id)data {
    HCModule *module = data;
    _doubleBannerView.module = module;
    [_doubleBannerView reloadData];
}

- (void)bindPush:(RACCommand *)push {
    self.push = push;
}

@end
