//
//  NewUserFeastView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/1.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "NewUserFeastView.h"
#import "Masonry.h"
#import "GlobalColors.h"
#import "HomePageHeadTitleView.h"
#import "ProductShowPriceCell.h"
#import "GlobalConstant.h"
#import "HCModuleData.h"
#import "RACEXTScope.h"
#import "UIImageView+HCPackWebImage.h"

@implementation NewUserFeastView {
    HomePageHeadTitleView *_headTitleView;
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
    //417
    //43
    _headTitleView = ({
        HomePageHeadTitleView *view = [[HomePageHeadTitleView alloc] initWithShowMore:NO];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@43);
        }];
        
        view;
    });
    
    //图片 8:5
    _feastImageView = ({
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
    
//    _feastImageView.backgroundColor = [UIColor orangeColor];
    
    //产品网格 320:174
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _productGridView = ({
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:collectionView];
        
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_feastImageView.mas_bottom);
            make.left.right.equalTo(self);
            make.height.equalTo(self.mas_width).multipliedBy(174.0/320.0);
        }];
        
        [collectionView registerNib:[UINib nibWithNibName:@"ProductShowPriceCell" bundle:nil] forCellWithReuseIdentifier:kProductShowPriceCellIdentifier];
        
        collectionView;
    });
//    _productGridView.backgroundColor = [UIColor redColor];
    
//    CGFloat viewWidth = [[UIScreen mainScreen] bounds].size.width;
//    _height = 43 + viewWidth/8.0*5 + viewWidth/320.0*174;
}

- (void)reloadData {
    if (_userFeastModule.data.count == 4) {
        _headTitleView.headModule = _userFeastModule;
        HCModuleData *data = _userFeastModule.data.firstObject;
        
        [_feastImageView packAspectFitModeSetImageWithURL:data.img placeholder:defaultImage02];
        
        [_productGridView reloadData];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat viewWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat collectionViewHeight = viewWidth*(174.0/320.0);
    
    return CGSizeMake((viewWidth-40)/3.0-1, (collectionViewHeight-20));
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductShowPriceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kProductShowPriceCellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor grayColor];
    HCModuleData *moduleData = _userFeastModule.data[indexPath.row+1];
    [cell.imageView packAspectFitModeSetImageWithURL:moduleData.img placeholder:defaultImage02];
    cell.nameLabel.text = moduleData.title;
    cell.priceLabel.text = [NSString stringWithFormat:@"%.2f", [moduleData.product_price doubleValue]];
    return cell;
}

#pragma mark - UICollectionViewDelegate


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
