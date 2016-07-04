//
//  WearTemplateViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "WearTemplateViewCell.h"
#import "Masonry.h"

@implementation WearTemplateViewCell
{
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _wearTemplateView = ({
            WearTemplateView *view = [WearTemplateView new];
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
