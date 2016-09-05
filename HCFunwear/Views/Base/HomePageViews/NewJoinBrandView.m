//
//  NewJoinBrandView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "NewJoinBrandView.h"
#import "Masonry.h"
#import "GlobalColors.h"
#import "GlobalConstant.h"
#import "ProductShowStyleCell.h"
#import "BrandBorderCell.h"
#import "RACEXTScope.h"
#import "UIImageView+HCPackWebImage.h"

@implementation NewJoinBrandView {
    UICollectionView *_productGridView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI {
    
    //图片 5:8
    _modelImageView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.image = [UIImage imageNamed:@"fan_default_01"];
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.right.equalTo(self);
            make.height.equalTo(self.mas_width).multipliedBy(5.0/8.0);
        }];
        
        imageView;
    });
    
    //产品网格  23:32
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _productGridView = ({
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:collectionView];
        
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_modelImageView.mas_bottom);
            make.left.right.equalTo(self);
            make.height.equalTo(self.mas_width).multipliedBy(23/32.0);
        }];
        
        [collectionView registerNib:[UINib nibWithNibName:@"BrandBorderCell" bundle:nil] forCellWithReuseIdentifier:kBrandBorderCellIdentifier];
        
        collectionView;
    });
    //    _productGridView.backgroundColor = [UIColor redColor];
}

- (void)reloadData {
    if (_module.data.count == 7) {
        HCModuleData *data = _module.data.firstObject;
        
        [_modelImageView packAspectFitModeSetImageWithURL:data.img placeholder:defaultImage02];
        
        [_productGridView reloadData];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat viewWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat collectionViewHeight = viewWidth*(23/32.0);
    
    return CGSizeMake((viewWidth-30)/3.0, (collectionViewHeight-35)/2.0);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 20, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BrandBorderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBrandBorderCellIdentifier forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor grayColor];
    HCModuleData *moduleData = _module.data[indexPath.row+1];
    [cell.imageView packAspectFitModeSetImageWithURL:moduleData.img placeholder:defaultImage02];
    return cell;
}

#pragma mark - UICollectionViewDelegate

@end
