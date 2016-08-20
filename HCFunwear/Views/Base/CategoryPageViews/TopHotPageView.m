//
//  TopHotPageView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "TopHotPageView.h"
#import "Masonry.h"
#import "TopHotReusableView.h"
#import "GlobalConstant.h"
#import "HotCategoryPageViewCell.h"
#import "ReactiveCocoa.h"
#import "HCHotModuleData.h"
#import "UIImageView+Image.h"
#import "HCFunwearRefreshHeader.h"

static NSString *kTopHotReusableViewIdentifier = @"kTopHotReusableViewIdentifier";
@implementation TopHotPageView {
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
    //collectionView : ReusableView + cell
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_collectionView registerClass:[TopHotReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kTopHotReusableViewIdentifier];
    [_collectionView registerNib:[UINib nibWithNibName:@"HotCategoryPageViewCell" bundle:nil] forCellWithReuseIdentifier:kHotCategoryPageViewCellIdentifier];
    
    @weakify(self);
    _collectionView.mj_header = [HCFunwearRefreshHeader headerWithRefreshingBlock:^{
        [[self.cateViewModel.layoutRequestCommand execute:nil] subscribeNext:^(HCCategoryLayout *layout) {
            @strongify(self);
            self.cateMoudule = layout;
            [self reload];
            [_collectionView.mj_header endRefreshing];
        }];
    }];
}

- (void)reload {
    [_collectionView reloadData];
}
- (void)beginRefresh {
    [_collectionView.mj_header beginRefreshing];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cateMoudule.hotCategoryModul.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotCategoryPageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHotCategoryPageViewCellIdentifier forIndexPath:indexPath];
    HCHotModuleData *data = _cateMoudule.hotCategoryModul.list[indexPath.row];
    [cell.imageView toloadImageWithURL:data.img placeholder:defaultImage03];
    cell.nameLabel.text = data.name;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TopHotReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kTopHotReusableViewIdentifier forIndexPath:indexPath];
        NSArray *urls = [[_cateMoudule.topPicModul.list.rac_sequence map:^id(HCHotModuleData *value) {
            return value.img;
        }] array];
        [reusableview.circulateScrollView loadView:urls];
        [reusableview reloadHotBrandsWithDatas:_cateMoudule.hotBrandModul.list];
        return reusableview;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat itemWidth = (screenWidth - 13 * 2 - 10)/2.0;
    return CGSizeMake(itemWidth, itemWidth);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 13, 10+50, 13);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    return CGSizeMake(screenWidth, screenWidth/160.0*53 + 22*2 + 34 * 2 + 111);
}

@end
