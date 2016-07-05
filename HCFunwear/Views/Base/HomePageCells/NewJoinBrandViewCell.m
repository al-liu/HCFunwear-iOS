//
//  NewJoinBrandViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/5.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "NewJoinBrandViewCell.h"
#import "Masonry.h"
#import "NewJoinBrandView.h"

@implementation NewJoinBrandViewCell
{
    NewJoinBrandView *_newJoinBrandView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _newJoinBrandView = ({
            NewJoinBrandView *view = [NewJoinBrandView new];
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
