//
//  WearTemplateView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "WearTemplateView.h"
#import "Masonry.h"
#import "GlobalColors.h"
#import "GlobalConstant.h"
#import "ProductShowStyleCell.h"
#import "UIImageView+YYWebImage.h"
#import "SingleImageCell.h"
#import "RACEXTScope.h"

@implementation WearTemplateView {
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
    //415
    //43
    _headTitleView = ({
        HomePageHeadTitleView *view = [[HomePageHeadTitleView alloc] initWithShowMore:YES];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@43);
        }];
        
        view;
    });
    
    //图片 8:5
    _modelImageView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.image = [UIImage imageNamed:@"fan_default_01"];
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headTitleView.mas_bottom);
            make.left.right.equalTo(self);
            make.height.equalTo(self.mas_width).multipliedBy(5.0/8.0);
        }];
        
        imageView;
    });
//    _modelImageView.backgroundColor = [UIColor orangeColor];
    
    //产品网格  32:17
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
            make.height.equalTo(self.mas_width).multipliedBy(17/32.0);
        }];
        
        [collectionView registerNib:[UINib nibWithNibName:@"SingleImageCell" bundle:nil] forCellWithReuseIdentifier:kSingleImageCellIdentifier];
        
        collectionView;
    });
//    _productGridView.backgroundColor = [UIColor redColor];
}

- (void)reloadData {
    if (_module.data.count == 4) {
        _headTitleView.headModule = _module;
        HCModuleData *data = _module.data.firstObject;
        
        @weakify(self);
        [_modelImageView setImageWithURL:data.img placeholder:defaultImage03 options:YYWebImageOptionAvoidSetImage completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            @strongify(self)
            self.modelImageView.image = image;
            self.modelImageView.contentMode = UIViewContentModeScaleAspectFit;
        }];

        [_productGridView reloadData];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat viewWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat collectionViewHeight = viewWidth*(17/32.0);
    
    return CGSizeMake((viewWidth-40)/3.0-1, (collectionViewHeight-20));
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SingleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSingleImageCellIdentifier forIndexPath:indexPath];
    HCModuleData *moduleData = _module.data[indexPath.row+1];
    [cell.imageView setImageWithURL:moduleData.img placeholder:defaultImage03 options:YYWebImageOptionAllowBackgroundTask completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        cell.imageView.image = image;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

@end
