//
//  HomePageHeadTitleView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/1.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HomePageHeadTitleView.h"
#import "Masonry.h"
#import "GlobalColors.h"

@implementation HomePageHeadTitleView {
    
    UIButton *_moreButton;
}

- (instancetype)initWithShowMore:(BOOL)flag {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _isShowMore = flag;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    //header h:43
    _titleLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
        label.text = @"新手专项";
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.bottom.equalTo(self);
        }];
        
        [label setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                               forAxis:UILayoutConstraintAxisHorizontal];
        [label setContentHuggingPriority:UILayoutPriorityDefaultHigh
                                 forAxis:UILayoutConstraintAxisHorizontal];
        
        label;
    });
    //43-30 h:13
    UIView *verticalLine = ({
        UIView *view = [UIView new];
        view.backgroundColor = kCellLineColor;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@1);
            make.top.equalTo(@15);
            make.bottom.equalTo(self).offset(-15);
            make.left.equalTo(_titleLabel.mas_right).offset(5);
        }];
        view;
    });
    
    //更多摁钮 ... ˙˙˙⋅⋅⋅⋯ ⋯
    _moreButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"⋯" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self);
            if (_isShowMore) {
                make.width.equalTo(@40);
            }
            else {
                 make.width.equalTo(@0);
            }
        }];
        
        button;
    });
    
    _titleEnLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = kCellLineColor;
        [self addSubview:label];
        label.text = @"New";
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(verticalLine.mas_right).offset(5);
            make.top.bottom.equalTo(self);
            //width >= 50
            make.width.greaterThanOrEqualTo(@50);
            make.right.equalTo(_moreButton.mas_left);
        }];
        
        [label setContentCompressionResistancePriority:UILayoutPriorityDefaultLow-1
                                               forAxis:UILayoutConstraintAxisHorizontal];
        [label setContentHuggingPriority:UILayoutPriorityDefaultLow
                                 forAxis:UILayoutConstraintAxisHorizontal];
        
        label;
    });
    
    
}

- (void)setHeadModel:(HeadTitleModel *)headModel {
    _headModel = headModel;
    _titleLabel.text = _headModel.title;
    _titleEnLabel.text = _headModel.titleEn;
    _isShowMore = _headModel.isShowMore;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation HeadTitleModel

- (instancetype)initWithTitle:(NSString *)title
                 englishTitle:(NSString *)titleEn
                   isShowMore:(BOOL)flag {
    self = [super init];
    if (self) {
        _title = title;
        _titleEn = titleEn;
        _isShowMore = flag;
    }
    return self;
}

@end

