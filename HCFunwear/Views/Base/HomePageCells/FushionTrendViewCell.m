//
//  FushionTrendViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "FushionTrendViewCell.h"
#import "FushionTrendView.h"
#import "Masonry.h"
#import "UICollectionViewCell+RACCommand.h"

@implementation FushionTrendViewCell {
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _fushionTrendView = ({
            FushionTrendView *view = [FushionTrendView new];
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
    _fushionTrendView.module = module;
    [_fushionTrendView reloadData];
}

- (void)bindPush:(RACCommand *)push {
    self.push = push;
}

@end
