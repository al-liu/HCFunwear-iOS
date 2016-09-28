//
//  HCBottomGoodsDetailView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/27.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCBottomGoodsDetailView.h"
#import "HCSelectedMoudleView.h"
#import "Masonry.h"
#import "HCProductDetailCollectionView.h"
#import "HCProductDetailAppraiseView.h"
#import "HCProductDetailNoticeView.h"

@interface HCBottomGoodsDetailView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HCBottomGoodsDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    //Selected Moudle
    HCSelectedMoudleView *selectedMoudleView = [[HCSelectedMoudleView alloc]initWithTitles:@[@"商品详情",@"全部评价(0)",@"购买咨询"]];
    [self addSubview:selectedMoudleView];
    
    [selectedMoudleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@43);
    }];
    
    //scorll view
    self.scrollView = ({
        UIScrollView *view = [UIScrollView new];
        view.pagingEnabled = YES;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(selectedMoudleView.mas_bottom);
            make.bottom.left.right.equalTo(self);
        }];
        
        view;
    });
    
    HCProductDetailCollectionView *detailCollectionView = ({
        HCProductDetailCollectionView *view = [HCProductDetailCollectionView new];
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.scrollView);
            make.width.equalTo(self);
            make.height.equalTo(self.mas_height).offset(-43);
        }];
        
        view;
    });
    
    HCProductDetailAppraiseView *detailAppraiseView = ({
        HCProductDetailAppraiseView *view = [HCProductDetailAppraiseView new];
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.scrollView);
            make.left.equalTo(detailCollectionView.mas_right);
            make.width.equalTo(self);
            make.height.equalTo(detailCollectionView);
        }];
        
        view;
    });
    
    HCProductDetailNoticeView *detailNoticeView = ({
        HCProductDetailNoticeView *view = [HCProductDetailNoticeView new];
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.scrollView);
            make.left.equalTo(detailAppraiseView.mas_right);
            make.width.equalTo(self);
            make.height.equalTo(detailAppraiseView);
        }];
        
        view;
    });

    
}

@end
