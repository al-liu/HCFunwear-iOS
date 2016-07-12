//
//  ShoppingBagNoGoodsView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/11.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ShoppingBagNoGoodsView.h"
#import "ShoppingBagDefaultVIew.h"
#import "Masonry.h"
#import "SingleImageCell.h"
#import "GlobalConstant.h"
#import "ShoppingBagReusableView.h"
#import "CategoryPageHeadTitleView.h"

static NSString *kShoppingBagHeaderIdentifier = @"kShoppingBagHeaderIdentifier";
@implementation ShoppingBagNoGoodsView {
    ShoppingBagDefaultVIew *defaultView;
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
    //404+36=440
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-49);
        make.height.equalTo(@202);
    }];
    
    [collectionView registerNib:[UINib nibWithNibName:@"SingleImageCell" bundle:nil] forCellWithReuseIdentifier:kSingleImageCellIdentifier];
    
    CategoryPageHeadTitleView *headView = ({
        CategoryPageHeadTitleView *view = [[CategoryPageHeadTitleView alloc]initWithShowMore:NO];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@36);
            make.left.right.equalTo(self);
            make.bottom.equalTo(collectionView.mas_top);
        }];
        
        view;
    });
    headView.titleLabel.text = @"优选新品";
    headView.titleEnLabel.text = @"New Arrivals";
    
    defaultView = ({
        ShoppingBagDefaultVIew *view = [[NSBundle mainBundle] loadNibNamed:@"ShoppingBagDefaultVIew" owner:self options:nil].lastObject;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.bottom.equalTo(headView.mas_top);
        }];
        
        view;
    });
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
