//
//  TopHotReusableView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "TopHotReusableView.h"
#import "HCCirculateScrollView.h"
#import "Masonry.h"
#import "CategoryPageHeadTitleView.h"
#import "HotBrandViewCell.h"
#import "GlobalConstant.h"

@implementation TopHotReusableView {
    HCCirculateScrollView *_circulateScrollView;
    CategoryPageHeadTitleView *_headBrandTitleView;
    CategoryPageHeadTitleView *_headCategoryTitleView;
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
    //32:21
    _circulateScrollView = ({
        HCCirculateScrollView *view = [HCCirculateScrollView new];
        view.image = [UIImage imageNamed:@"fan_default_01"];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(self.mas_width).multipliedBy(21/32.0);
        }];
        
        view;
    });
    
    //TODO: 留给 PageControll top:5 height:2 bottom:15
    
    //top:22 h:34
    _headBrandTitleView = ({
        CategoryPageHeadTitleView *view = [CategoryPageHeadTitleView new];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_circulateScrollView.mas_bottom).offset(22);
            make.left.right.equalTo(self);
            make.height.equalTo(@34);
        }];
        
        view;
    });

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headBrandTitleView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@111);
    }];
    
    [collectionView registerNib:[UINib nibWithNibName:@"HotBrandViewCell" bundle:nil] forCellWithReuseIdentifier:kHotBrandViewCellIdentifier];
    
    _headCategoryTitleView = ({
        CategoryPageHeadTitleView *view = [CategoryPageHeadTitleView new];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(collectionView.mas_bottom).offset(22);
            make.left.right.equalTo(self);
            make.height.equalTo(@34);
        }];
        
        view;
    });
    
    _headBrandTitleView.titleLabel.text = @"热门品牌";
    _headBrandTitleView.titleEnLabel.text = @"Hot Brands";
    _headCategoryTitleView.titleLabel.text = @"热门品类";
    _headCategoryTitleView.titleEnLabel.text = @"Hot Gategory";
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotBrandViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHotBrandViewCellIdentifier forIndexPath:indexPath];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(112, 91);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 15, 10, 15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
#pragma mark - UICollectionViewDelegateFlowLayout

@end
