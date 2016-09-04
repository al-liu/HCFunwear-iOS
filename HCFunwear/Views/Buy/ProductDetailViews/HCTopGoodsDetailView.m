//
//  HCTopGoodsDetailView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/2.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCTopGoodsDetailView.h"
#import "HCGoodsDetailShowPictureView.h"
#import "Masonry.h"
#import "HCGoodsPriceView.h"
#import "GlobalImport.h"

@interface HCTopGoodsDetailView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HCTopGoodsDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = kBaseViewBGColor;
    
    self.scrollView = ({
        UIScrollView *view = [UIScrollView new];
//        view.delegate = self;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        view;
    });
    
    //图片浏览 320:388.5
    HCGoodsDetailShowPictureView *showPictureView = ({
        HCGoodsDetailShowPictureView *view = [HCGoodsDetailShowPictureView new];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(self.mas_width).multipliedBy(388.5/320.0);
        }];
        
        view;
    });
    
    //价格和名字
    HCGoodsPriceView *goodsPriceView = ({
        HCGoodsPriceView *view = [HCGoodsPriceView new];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(showPictureView.mas_bottom);
        }];
        
        view;
    });
    
    //保障 320:38
    UIButton *explainButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.showsTouchWhenHighlighted = NO;
        button.backgroundColor = [UIColor whiteColor];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(goodsPriceView.mas_bottom);
            make.height.equalTo(self.mas_width).multipliedBy(38/320.0);
        }];
        
        button;
    });
    
    //这里是根据活动数量动态展示的
    DDLogWarn(@"HCTopGoodsDetailView 需要 数据动态生成 UI");
    
    
    
}

@end
