//
//  TopHotReusableView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "TopHotReusableView.h"
#import "Masonry.h"
#import "CategoryPageHeadTitleView.h"
#import "HotBrandViewCell.h"
#import "GlobalConstant.h"
#import "HCHotModuleData.h"
#import "UIImageView+Image.h"

@implementation TopHotReusableView {
    
    CategoryPageHeadTitleView *_headBrandTitleView;
    CategoryPageHeadTitleView *_headCategoryTitleView;
    
    UICollectionView *_collectionView;
    
    NSArray *_hotBrandList;
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
    //53:160
    _circulateScrollView = ({
        HCCirculateScrollView *view = [HCCirculateScrollView new];
        view.image = [UIImage imageNamed:@"fan_default_01"];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(self.mas_width).multipliedBy(53/160.0);
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
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headBrandTitleView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@111);
    }];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"HotBrandViewCell" bundle:nil] forCellWithReuseIdentifier:kHotBrandViewCellIdentifier];
    
    _headCategoryTitleView = ({
        CategoryPageHeadTitleView *view = [CategoryPageHeadTitleView new];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_collectionView.mas_bottom).offset(22);
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

- (void)reloadHotBrandsWithDatas:(NSArray *)datas {
    _hotBrandList = datas;
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _hotBrandList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotBrandViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHotBrandViewCellIdentifier forIndexPath:indexPath];
    HCHotModuleData *data = _hotBrandList[indexPath.row];
    [cell.imageView toloadImageWithURL:data.img placeholder:defaultImage02];
    cell.nameLabel.text = data.name;
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
