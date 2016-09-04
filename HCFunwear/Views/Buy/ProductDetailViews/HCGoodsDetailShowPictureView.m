//
//  HCGoodsDetailShowPictureView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/2.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCGoodsDetailShowPictureView.h"
#import "SingleImageCell.h"
#import "GlobalConstant.h"
#import "GlobalColors.h"

@implementation HCGoodsDetailShowPictureView

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
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _showPictureView = ({
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:collectionView];
        
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [collectionView registerNib:[UINib nibWithNibName:@"SingleImageCell" bundle:nil] forCellWithReuseIdentifier:kSingleImageCellIdentifier];
        
        collectionView;
    });
    
    //page control label
    _pageControlLabel = ({
        UILabel *label = [UILabel new];
        label.layer.borderColor = kCellLineColor.CGColor;
        label.layer.borderWidth = .5f;
        label.font = [UIFont systemFontOfSize:10];
        label.text = @"2/10";
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@30);
            make.height.equalTo(@15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self).offset(-10);
        }];
        
        label;
    });
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    CGFloat viewHeight = CGRectGetHeight(self.frame);
    
    return CGSizeMake(viewWidth, viewHeight);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SingleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSingleImageCellIdentifier forIndexPath:indexPath];
    
    return cell;
}


@end
