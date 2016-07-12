//
//  NewArrivalsViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/12.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "NewArrivalsViewCell.h"
#import "SingleImageCell.h"
#import "GlobalConstant.h"
#import "Masonry.h"

@implementation NewArrivalsViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self.contentView addSubview:collectionView];
        collectionView.backgroundColor = [UIColor whiteColor];
        //202
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [collectionView registerNib:[UINib nibWithNibName:@"SingleImageCell" bundle:nil] forCellWithReuseIdentifier:kSingleImageCellIdentifier];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SingleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSingleImageCellIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(145, 182);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
