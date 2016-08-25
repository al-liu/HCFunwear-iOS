//
//  InspirationPageFunerView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "InspirationPageFunerView.h"
#import "Masonry.h"
#import "SingleImageCell.h"
#import "GlobalConstant.h"
#import "GlobalColors.h"
#import "UIImageView+Image.h"
#import "HCFunwearRefreshHeader.h"
#import "HCFunwearRefreshFooter.h"
#import "UIImageView+YYWebImage.h"
#import "UIImage+YYAdd.h"

@implementation InspirationPageFunerView {
    UICollectionView *_collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _funerDataList = [NSMutableArray array];
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
    
    _collectionView.mj_header = [HCFunwearRefreshHeader headerWithRefreshingBlock:^{
        _viewModel.funerPageIndex = 0;
        _funerDataList = [NSMutableArray array];
        [[_viewModel.funerRequestCommand execute:nil] subscribeNext:^(HCInspirationInfos *info) {
            [_collectionView.mj_header endRefreshing];
        }];
    }];
    
    _collectionView.mj_footer = [HCFunwearRefreshFooter footerWithRefreshingBlock:^{
        _viewModel.funerPageIndex += 1;
        [[_viewModel.funerRequestCommand execute:nil] subscribeNext:^(HCInspirationInfos *info) {
            [_collectionView.mj_footer endRefreshing];
        }];
    }];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"SingleImageCell" bundle:nil] forCellWithReuseIdentifier:kSingleImageCellIdentifier];
    
}

- (void)header_beginRefreshing {
    [_collectionView.mj_header beginRefreshing];
}

- (void)bindViewModel:(id)viewModel {
    _viewModel = viewModel;
    @weakify(self);
    [[RACObserve(_viewModel, inspFunerList) skip:1] subscribeNext:^(NSArray *infos) {
        @strongify(self);
        [_funerDataList addObjectsFromArray:infos];
        [self->_collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _funerDataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SingleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSingleImageCellIdentifier forIndexPath:indexPath];
    HCInspirationByUsers *inspUser = _funerDataList[indexPath.row];
    @weakify(self);
    self.contentMode = UIViewContentModeCenter;
    [cell.imageView setImageWithURL:inspUser.img placeholder:defaultImage02 options:YYWebImageOptionAllowBackgroundTask completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        @strongify(self);
//        cell.imageView.image = [image imageByResizeToSize:CGSizeMake([inspUser.img_width floatValue], [inspUser.img_height floatValue]) contentMode:UIViewContentModeScaleToFill];
        self.contentMode = UIViewContentModeScaleToFill;
        cell.imageView.image = image;
    }];
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemWidth = (SCREEN_WIDTH - 4)/2.0; // 79:104
    return CGSizeMake(itemWidth, itemWidth / 79.0 * 104);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}

@end
