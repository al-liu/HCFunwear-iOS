//
//  HomePageView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/16.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HomePageView.h"
#import "Masonry.h"

#import "HCFunwearRefreshHeader.h"
#import "HCFunwearRefreshFooter.h"

@interface HomePageView ()

@end
@implementation HomePageView

- (instancetype)initWithViewModel:(HomePageViewModel *)mdoel {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _homePageViewModel = mdoel;
        [self initCollectionView];
    }
    return self;

}

- (void)initCollectionView {
    UICollectionViewFlowLayout *homePageCollectionLayout = [[UICollectionViewFlowLayout alloc]init];
    
    _homePageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:homePageCollectionLayout];
    _homePageCollectionView.backgroundColor = [UIColor whiteColor];//kCommonColor
    [self addSubview:_homePageCollectionView];
    
    [_homePageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    _homePageCollectionView.mj_header = [HCFunwearRefreshHeader headerWithRefreshingBlock:^{
        [[_homePageViewModel.layoutRequestCommand execute:nil] subscribeNext:^(NSArray *modules) {
            [_homePageCollectionView.mj_header endRefreshing];
        }];
    }];
    
    _homePageCollectionView.mj_footer = [HCFunwearRefreshFooter footerWithRefreshingBlock:^{
        [[_homePageViewModel.productsRequestCommand execute:nil] subscribeNext:^(NSArray *productList) {
            _homePageViewModel.productsPage += 1;
            [_homePageCollectionView.mj_footer endRefreshing];
        }];
    }];
}

@end
