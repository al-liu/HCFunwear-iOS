//
//  MainStyleView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/5/25.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MainStyleView.h"
#import "GlobalColors.h"

@implementation MainStyleView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self layoutViews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutViews];
    }
    return self;
}

- (void)layoutViews {
    self.userInteractionEnabled = YES;
    self.backgroundColor = kMainStyleColor;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    UIImageView *arrowhead = ({
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"btn_more"];
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-21);
            make.centerY.equalTo(self);
        }];
        
        imageView;
    });
    
    _chTitleLabel = ({
        UILabel *label = [UILabel new];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(22);
            make.top.bottom.equalTo(self);
        }];
        
        label;
    });
    
    _enTitleLabel = ({
        UILabel *label = [UILabel new];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_chTitleLabel.mas_right).offset(12);
            make.top.bottom.equalTo(self);
            make.right.equalTo(arrowhead.mas_left).offset(10);
        }];
        
        label;
    });
    
    [arrowhead setContentHuggingPriority:UILayoutPriorityRequired
                                 forAxis:UILayoutConstraintAxisHorizontal];
    [arrowhead setContentCompressionResistancePriority:UILayoutPriorityRequired
                                               forAxis:UILayoutConstraintAxisHorizontal];
    [_chTitleLabel setContentHuggingPriority:UILayoutPriorityRequired
                                 forAxis:UILayoutConstraintAxisHorizontal];
    [_chTitleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                               forAxis:UILayoutConstraintAxisHorizontal];
    [_enTitleLabel setContentHuggingPriority:UILayoutPriorityRequired
                                 forAxis:UILayoutPriorityDefaultHigh];
    [_enTitleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                               forAxis:UILayoutPriorityDefaultHigh];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
