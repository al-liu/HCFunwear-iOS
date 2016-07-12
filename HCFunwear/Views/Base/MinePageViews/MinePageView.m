//
//  MinePageView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/12.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MinePageView.h"
#import "Masonry.h"
#import "MinePageUserHeadCell.h"
#import "MineMenuCell.h"
#import "MineOrderCell.h"
#import "MineTableMenuCell.h"
#import "GlobalConstant.h"
#import "GlobalColors.h"
#import "UIColor+YYAdd.h"
#import "NewArrivalsHeadCell.h"
#import "NewArrivalsViewCell.h"

static NSString *kMinePageUserHeadCellIdentifier = @"MinePageUserHeadCellIdentifier";
static NSString *kMineMenuCellIdentifier = @"MineMenuCellIdentifier";
static NSString *kMineOrderCellIdentifier = @"MineOrderCellIdentifier";
static NSString *kMineTableMenuCellIdentifier = @"MineTableMenuCellIdentifier";
static NSString *kNewArrivalsHeadCellIdentifier = @"kNewArrivalsHeadCellIdentifier";
static NSString *kNewArrivalsViewCellIdentifier = @"kNewArrivalsViewCellIdentifier";

@implementation MinePageView {
    UICollectionView *_collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)reloadData {
    [_collectionView reloadData];
}

- (void)initUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    _collectionView.backgroundColor = kCommonColor;
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //头像
    [_collectionView registerNib:[UINib nibWithNibName:@"MinePageUserHeadCell" bundle:nil] forCellWithReuseIdentifier:kMinePageUserHeadCellIdentifier];
    //我的菜单
    [_collectionView registerNib:[UINib nibWithNibName:@"MineMenuCell" bundle:nil] forCellWithReuseIdentifier:kMineMenuCellIdentifier];
    //表格
    [_collectionView registerNib:[UINib nibWithNibName:@"MineTableMenuCell" bundle:nil] forCellWithReuseIdentifier:kMineTableMenuCellIdentifier];
    //订单菜单
    [_collectionView registerNib:[UINib nibWithNibName:@"MineOrderCell" bundle:nil] forCellWithReuseIdentifier:kMineOrderCellIdentifier];
    //优选 title
    [_collectionView registerClass:[NewArrivalsHeadCell class] forCellWithReuseIdentifier:kNewArrivalsHeadCellIdentifier];
    //优选
    [_collectionView registerClass:[NewArrivalsViewCell class] forCellWithReuseIdentifier:kNewArrivalsViewCellIdentifier];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1 || section == 4 || section == 5) {
        return 3;
    }
    else if (section == 3) {//订单
        return 5;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//头部
        MinePageUserHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMinePageUserHeadCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 1) {//心愿等菜单
        MineMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMineMenuCellIdentifier forIndexPath:indexPath];
        cell.mineMenuModel = _minePageMenus[indexPath.row];
        return cell;
    }
    else if (indexPath.section == 2) {//我的订单
        MineTableMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMineTableMenuCellIdentifier forIndexPath:indexPath];
        cell.isShowAwakePoint = NO;
        cell.lineLeadingConstant = 15;
        return cell;
    }
    else if (indexPath.section == 3) {
        MineOrderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMineOrderCellIdentifier forIndexPath:indexPath];
        cell.mineMenuModel = _minePageOrderMenus[indexPath.row];
        return cell;
    }
    else if (indexPath.section == 4) {
        MineTableMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMineTableMenuCellIdentifier forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.tableMenuModel = [[MineTableMenuModel alloc]initWithTitle:@"地址管理"];
        }
        else if (indexPath.row == 1) {
            cell.tableMenuModel = [[MineTableMenuModel alloc]initWithTitle:@"我的会员" awake:YES];
        }
        else if (indexPath.row == 2) {
            cell.tableMenuModel = [[MineTableMenuModel alloc]initWithTitle:@"我的范票"];
        }
        return cell;
    }
    else if (indexPath.section == 5) {
        MineTableMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMineTableMenuCellIdentifier forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.tableMenuModel = [[MineTableMenuModel alloc]initWithTitle:@"在线客服"];
        }
        else if (indexPath.row == 1) {
            cell.tableMenuModel = [[MineTableMenuModel alloc]initWithTitle:@"意见反馈" awake:YES];
        }
        else if (indexPath.row == 2) {
            cell.tableMenuModel = [[MineTableMenuModel alloc]initWithTitle:@"有范问答赢范票"];
        }
        return cell;
    }
    else if (indexPath.section == 6) {
        MineTableMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMineTableMenuCellIdentifier forIndexPath:indexPath];
        cell.tableMenuModel = [[MineTableMenuModel alloc]initWithTitle:@"兑换范票"];
        return cell;
    }
    else if (indexPath.section == 7) {
        MineTableMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMineTableMenuCellIdentifier forIndexPath:indexPath];
        cell.tableMenuModel = [[MineTableMenuModel alloc]initWithTitle:@"扫一扫"];
        return cell;
    }
    else if (indexPath.section == 8) {
        NewArrivalsHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNewArrivalsHeadCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 9) {
        NewArrivalsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNewArrivalsViewCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH / 320.0 * 164);
    }
    else if (indexPath.section == 1) {
        CGFloat itemWidth = (SCREEN_WIDTH-1)/3.0;
        CGFloat itemHeight = itemWidth / 109.0 * 59;
        return CGSizeMake(itemWidth, itemHeight);
    }
    else if (indexPath.section == 2) {
        return CGSizeMake(SCREEN_WIDTH, 45);
    }
    else if (indexPath.section == 3) {
        CGFloat itemWidth = (SCREEN_WIDTH)/5.0;
        CGFloat itemHeight = itemWidth / 64.0 * 64;
        return CGSizeMake(itemWidth, itemHeight);
    }
    else if (indexPath.section == 8) {
        return CGSizeMake(SCREEN_WIDTH, 36);
    }
    else if (indexPath.section == 9) {
        return CGSizeMake(SCREEN_WIDTH, 202);
    }
    return CGSizeMake(SCREEN_WIDTH, 50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return 0.5f;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2) {
        return CGSizeMake(SCREEN_WIDTH, 0.5f);
    }
    else if (section == 4 || section == 5 || section == 6 || section == 7 || section == 8) {
        return CGSizeMake(SCREEN_WIDTH, 10);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 9) {
        return CGSizeMake(SCREEN_WIDTH, kTabBaHeight);
    }
    return CGSizeZero;
}

@end
