//
//  ShopTheLookView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ShopTheLookView.h"
#import "HomePageHeadTitleView.h"
#import "Masonry.h"
#import "GlobalConstant.h"
#import "LimitTimeBuyCell.h"

@implementation ShopTheLookView {
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
    //214 - 43 = 171
    _headTitleView = ({
        HomePageHeadTitleView *view = [[HomePageHeadTitleView alloc] initWithShowMore:NO];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@43);
        }];
        
        view;
    });
    _headTitleView.titleLabel.text = @"限时搭配购";
    _headTitleView.titleEnLabel.text = @"Shop the look";
    
    //17:32
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _productGridView = ({
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:collectionView];
        
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headTitleView.mas_bottom);
            make.left.right.equalTo(self);
            make.height.equalTo(self.mas_width).multipliedBy(17/32.0);
        }];
        
        [collectionView registerNib:[UINib nibWithNibName:@"LimitTimeBuyCell" bundle:nil] forCellWithReuseIdentifier:kLimitTimeBuyCellIdentifier];
        
        collectionView;
    });
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat viewWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat collectionViewHeight = viewWidth/32.0*17;
    
    return CGSizeMake((collectionViewHeight-22), (collectionViewHeight-22));
    //多减2，消除警告
    //the behavior of the UICollectionViewFlowLayout is notdefined because:
    //the item height must be less than the height of the UICollectionView minus thesection insets top and bottom values.
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 20, 0);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LimitTimeBuyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLimitTimeBuyCellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor grayColor];
    return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
