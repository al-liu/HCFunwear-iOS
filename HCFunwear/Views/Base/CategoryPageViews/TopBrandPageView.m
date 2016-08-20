//
//  TopBrandPageView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "TopBrandPageView.h"
#import "Masonry.h"
#import "SingleImageCell.h"
#import "GlobalConstant.h"
#import "HCFunwearRefreshHeader.h"
#import "HCFunwearRefreshFooter.h"
#import "HCBrand.h"
#import "UIImageView+Image.h"
#import "BrandsViewCell.h"

@implementation TopBrandPageView {
    UICollectionView *_collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"BrandsViewCell" bundle:nil] forCellWithReuseIdentifier:kBrandsViewCellIdentifier];
    
    @weakify(self);
    _collectionView.mj_header = [HCFunwearRefreshHeader headerWithRefreshingBlock:^{
        _cateViewModel.brandApi.pageIndex = 0;
        [[_cateViewModel.brandsRequestCommand execute:nil] subscribeNext:^(NSArray *brands) {
            @strongify(self);
            self.brandsList = [brands mutableCopy];
            [self reload];
            [_collectionView.mj_header endRefreshing];
        }];
    }];
    
    _collectionView.mj_footer = [HCFunwearRefreshFooter footerWithRefreshingBlock:^{
        _cateViewModel.brandApi.pageIndex += 1;
        [[_cateViewModel.brandsRequestCommand execute:nil] subscribeNext:^(NSArray *brands) {
            @strongify(self);
            [self.brandsList addObjectsFromArray:brands];
            [self reload];
            [_collectionView.mj_footer endRefreshing];
        }];
    }];
}

- (void)beginRefresh {
    [_collectionView.mj_header beginRefreshing];
}

- (void)reload {
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _brandsList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BrandsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBrandsViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    HCBrand *brand = _brandsList[indexPath.row];
    [cell.imageView toloadImageWithURL:brand.logo_img placeholder:defaultImage04];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat itemWidth = (screenWidth - 1)/3.0;
    return CGSizeMake(itemWidth, itemWidth);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0.5f, 0, 0.5f, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5f;
}

@end
