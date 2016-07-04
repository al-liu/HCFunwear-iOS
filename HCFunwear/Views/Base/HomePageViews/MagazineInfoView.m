//
//  MagazineInfoView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MagazineInfoView.h"
#import "HomePageHeadTitleView.h"
#import "Masonry.h"
#import "GlobalConstant.h"
#import "HCCirculateScrollView.h"

@implementation MagazineInfoView{
    HomePageHeadTitleView *_headTitleView;
    HCCirculateScrollView *_circulateScrollView;
    UILabel *_infoLabel;
}
//575
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI {
    //288 - 43 = 245
    _headTitleView = ({
        HomePageHeadTitleView *view = [[HomePageHeadTitleView alloc] initWithShowMore:YES];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@43);
        }];
        
        view;
    });
    _headTitleView.titleLabel.text = @"流行资讯";
    _headTitleView.titleEnLabel.text = @"Magazine";
    
    //23:40
    _circulateScrollView = ({
        HCCirculateScrollView *view = [HCCirculateScrollView new];
        view.image = [UIImage imageNamed:@"fan_default_01"];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headTitleView.mas_bottom);
            make.left.right.equalTo(self);
            make.height.equalTo(self.mas_width).multipliedBy(23/40.0);
        }];
        
        view;
    });
    
    _infoLabel = ({
        UILabel *view = [UILabel new];
        view.font = [UIFont systemFontOfSize:15];
        view.textAlignment = NSTextAlignmentCenter;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_circulateScrollView.mas_bottom).offset(15);
            make.left.right.equalTo(self);
        }];
        
        view;
    });
    _infoLabel.text = @"NEWS | 欧洲“男模”杯，看球看脸看制服";
    
    //下面需要加 PageControl 自定义
    //h: 61
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
