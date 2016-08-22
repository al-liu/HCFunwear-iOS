//
//  NewUserFeastViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "NewUserFeastViewCell.h"
#import "NewUserFeastView.h"
#import "Masonry.h"
#import "UICollectionViewCell+RACCommand.h"

@implementation NewUserFeastViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _feastView = ({
            NewUserFeastView *view = [NewUserFeastView new];
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
    _feastView.userFeastModule = module;
    [_feastView reloadData];
}

- (void)bindPush:(RACCommand *)push {
    self.push = push;
}

@end
