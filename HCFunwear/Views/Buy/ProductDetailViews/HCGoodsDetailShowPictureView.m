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
#import "HCProductDetailModel.h"
#import "UIImageView+HCPackWebImage.h"

@interface HCGoodsDetailShowPictureView ()

@property (nonatomic, strong) NSArray *list;

@end

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
        collectionView.pagingEnabled = YES;
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
        label.textAlignment = NSTextAlignmentCenter;
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

- (void)reloadData:(NSArray *)list {
    _list = list;
    [_showPictureView reloadData];
    _pageControlLabel.text = [NSString stringWithFormat:@"0/%ld",_list.count];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    _pageControlLabel.text = [NSString stringWithFormat:@"%ld/%ld",index,_list.count];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    CGFloat viewHeight = CGRectGetHeight(self.frame);
    
    return CGSizeMake(viewWidth, viewHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SingleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSingleImageCellIdentifier forIndexPath:indexPath];
    
    HCPicUrl *pic = _list[indexPath.row];
    [cell.imageView packAspectFillModeSetImageWithURL:pic.filE_PATH placeholder:defaultImage02];
    
    return cell;
}


@end
