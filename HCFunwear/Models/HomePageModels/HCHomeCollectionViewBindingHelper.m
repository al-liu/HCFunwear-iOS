//
//  HCHomeCollectionViewBindingHelper.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCHomeCollectionViewBindingHelper.h"

#import "HCCirculateScrollViewCell.h"
#import "HCGridMenuViewCell.h"
#import "SinglePageAdvertViewCell.h"
#import "NewUserFeastViewCell.h"
#import "HotCategoryViewCell.h"
#import "PopularBrandsViewCell.h"
#import "FushionTrendViewCell.h"
#import "ShopTheLookViewCell.h"
#import "MagazineInfoViewCell.h"
#import "WearTemplateViewCell.h"
#import "DoubleBannerViewCell.h"
#import "NewJoinBrandViewCell.h"
#import "RecommendedViewCell.h"
#import "ProductShowBrandPriceCell.h"
#import "HomePageHeadReusableView.h"

#import "GlobalConstant.h"
#import "GlobalColors.h"

#import "HCModule.h"
#import "HCModuleData.h"
#import "HCCollectionCellInfo.h"
#import "UIImageView+YYWebImage.h"
#import "HCHomeModuleCellProtocol.h"

static NSString *kCirculateScrollCellIdentifier      = @"kCirculateScrollCellIdentifier";
static NSString *kGridMenuCellIdentifier             = @"kGridMenuCellIdentifier";
static NSString *kSinglePageAdvertCellIdentifier     = @"kSinglePageAdvertCellIdentifier";
static NSString *kNewUserFeastCellIdentifier         = @"kNewUserFeastCellIdentifier";
static NSString *kHotCategoryViewCellIdentifier      = @"kHotCategoryViewCellIdentifier";
static NSString *kPopularBrandsViewCellIdentifier    = @"kPopularBrandsViewCellIdentifier";
static NSString *kFushionTrendViewCellIdentifier     = @"kFushionTrendViewCellIdentifier";
static NSString *kShopTheLookViewCellIdentifier      = @"kShopTheLookViewCellIdentifier";
static NSString *kMagazineInfoViewCellIdentifier     = @"kMagazineInfoViewCellIdentifier";
static NSString *kWearTemplateViewCellIdentifier     = @"kWearTemplateViewCellIdentifier";
static NSString *kDoubleBannerViewCellIdentifier     = @"kDoubleBannerViewCellIdentifier";
static NSString *kNewJoinBrandViewCellIdentifier     = @"kNewJoinBrandViewCellIdentifier";
static NSString *kRecommendedViewCellIdentifier      = @"kRecommendedViewCellIdentifier";
static NSString *kHomePageHeadReusableViewIdentifier = @"kHomePageHeadReusableViewIdentifier";

@implementation HCHomeCollectionViewBindingHelper {
    UICollectionView *_collectionView;
    NSArray *_data;
    NSArray *_productsData;
    NSDictionary *_moudelDictionary;
    
    RACCommand *_push;
}

- (instancetype) initWithCollectionView:(UICollectionView *)collectionView
                           sourceSignal:(RACSignal *)source
                         productsSignal:(RACSignal *)products
                            pushCommand:(RACCommand *)push{
    self = [super init];
    if (self) {
        _collectionView = collectionView;
        _data = [NSArray array];
        _productsData = [NSArray array];
        _push = push;
        
        [[source skip:1] subscribeNext:^(id x) {
            self->_data = x;
            //手动添加 猜你喜欢的 模块 方便数据源使用
            HCModule *lastModule = self->_data.lastObject;
            NSAssert(![lastModule.module_key isEqualToString:@"likeProductModule"], @"新的布局数据不应该还有猜你喜欢的产品模块");
            
            HCModule *likeModule = [[HCModule alloc]init];
            likeModule.module_id = @"-1";
            likeModule.c_title = @"猜你喜欢";
            likeModule.e_title = @"";
            likeModule.module_key = @"likeProductModule";
            
            NSMutableArray *mutableArray = [self->_data mutableCopy];
            [mutableArray addObject:likeModule];
            self->_data = [mutableArray copy];
            
            [self->_collectionView reloadData];
        }];
        
        [[products skip:1] subscribeNext:^(id x) {
            self->_productsData = x;
            [self->_collectionView reloadData];
        }];
        
        [self registerCollectionCells];
        [self registerCollectionCellsInfo];
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
    }
    return self;
}

+ (instancetype) initWithCollectionView:(UICollectionView *)collectionView
                           sourceSignal:(RACSignal *)source
                         productsSignal:(RACSignal *)products
                            pushCommand:(RACCommand *)push{
    return [[HCHomeCollectionViewBindingHelper alloc] initWithCollectionView:collectionView
                                                                sourceSignal:source
                                                              productsSignal:products
                                                                 pushCommand:push];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    HCModule *module = _data[indexPath.section];
    HCCollectionCellInfo *info = _moudelDictionary[module.module_key];
    return info.sizeItem;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    HCModule *module = _data[section];
    HCCollectionCellInfo *info = _moudelDictionary[module.module_key];
    return info.minimumLineSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    HCModule *module = _data[section];
    HCCollectionCellInfo *info = _moudelDictionary[module.module_key];
    return info.referenceSizeForHeader;
    //    if (section == 0 || section == 1 || section == 18/*猜你喜欢*/) {
    //        return CGSizeZero;
    //    }
    //    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    //    CGFloat screenWidth = screenSize.width;
    //    return CGSizeMake(screenWidth, 10);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == _data.count-1) {//猜你喜欢产品的组
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    HCModule *module = _data[section];
    HCCollectionCellInfo *info = _moudelDictionary[module.module_key];
    return info.insetForSection;
    //    return UIEdgeInsetsZero;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _data.count;//猜你喜欢
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == _data.count-1) {//猜你喜欢产品的组
        return _productsData.count;
    }
    return 1;
}
#warning home page limit time without moudle key 在现有的接口返回的数据里看不到 限时搭配购的 moudle key
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HCModule *module = _data[indexPath.section];
    if ([module.module_key isEqualToString:@"likeProductModule"]) {
        ProductShowBrandPriceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kProductShowBrandPriceCellIdentifier forIndexPath:indexPath];
        cell.product = _productsData[indexPath.row];
        return cell;
    }
    else {
        HCCollectionCellInfo *info = _moudelDictionary[module.module_key];
        id <HCHomeModuleCellProtocol> otherCell = [collectionView dequeueReusableCellWithReuseIdentifier:info.identifier forIndexPath:indexPath];
        [otherCell bindData:module];
        [otherCell bindPush:_push];
        return (UICollectionViewCell *)otherCell;
    }
    
    return nil;
    /*
     else if (indexPath.section == 7) {//暂时没有在接口中看到
     ShopTheLookViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kShopTheLookViewCellIdentifier forIndexPath:indexPath];
     return cell;
     }
     */
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHomePageHeadReusableViewIdentifier forIndexPath:indexPath];
        reusableview.backgroundColor = kCommonColor;
    }
    return reusableview;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


/**
 *  注册模块 Cell
 */
- (void)registerCollectionCells {
    //广告轮播
    [_collectionView registerClass:[HCCirculateScrollViewCell class]
                forCellWithReuseIdentifier:kCirculateScrollCellIdentifier];
    //八宫格菜单
    [_collectionView registerClass:[HCGridMenuViewCell class]
                forCellWithReuseIdentifier:kGridMenuCellIdentifier];
    //单页广告
    [_collectionView registerClass:[SinglePageAdvertViewCell class]
                forCellWithReuseIdentifier:kSinglePageAdvertCellIdentifier];
    //新手专享
    [_collectionView registerClass:[NewUserFeastViewCell class]
                forCellWithReuseIdentifier:kNewUserFeastCellIdentifier];
    //热门品类
    [_collectionView registerClass:[HotCategoryViewCell class]
                forCellWithReuseIdentifier:kHotCategoryViewCellIdentifier];
    //热门品牌
    [_collectionView registerClass:[PopularBrandsViewCell class]
                forCellWithReuseIdentifier:kPopularBrandsViewCellIdentifier];
    //搭配趋势
    [_collectionView registerClass:[FushionTrendViewCell class]
                forCellWithReuseIdentifier:kFushionTrendViewCellIdentifier];
    //限时搭配购
    [_collectionView registerClass:[ShopTheLookViewCell class]
                forCellWithReuseIdentifier:kShopTheLookViewCellIdentifier];
    //流行资讯
    [_collectionView registerClass:[MagazineInfoViewCell class]
                forCellWithReuseIdentifier:kMagazineInfoViewCellIdentifier];
    //穿戴:上装，下装，鞋履，包袋，配饰，男士护理，户外运动
    [_collectionView registerClass:[WearTemplateViewCell class]
                forCellWithReuseIdentifier:kWearTemplateViewCellIdentifier];
    //两个广告栏
    [_collectionView registerClass:[DoubleBannerViewCell class]
                forCellWithReuseIdentifier:kDoubleBannerViewCellIdentifier];
    //新入住品牌
    [_collectionView registerClass:[NewJoinBrandViewCell class]
                forCellWithReuseIdentifier:kNewJoinBrandViewCellIdentifier];
    //猜你喜欢头标题
    [_collectionView registerClass:[RecommendedViewCell class]
                forCellWithReuseIdentifier:kRecommendedViewCellIdentifier];
    //猜你喜欢产品
    [_collectionView registerNib:[UINib nibWithNibName:@"ProductShowBrandPriceCell" bundle:nil]
              forCellWithReuseIdentifier:kProductShowBrandPriceCellIdentifier];
    //首页常用组头Head
    [_collectionView registerClass:[HomePageHeadReusableView class]
                forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                       withReuseIdentifier:kHomePageHeadReusableViewIdentifier];
}

- (void)registerCollectionCellsInfo {
    NSMutableDictionary *cellInfoDictionary = [[NSMutableDictionary alloc]initWithCapacity:14];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat screenWidth = screenSize.width;
    
    HCCollectionCellInfo *circulateScrollViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kCirculateScrollCellIdentifier
                                                                                               sizeItem:CGSizeMake(screenWidth, screenWidth/160.0*79)
                                                                                     minimumLineSpacing:0
                                                                                 referenceSizeForHeader:CGSizeZero
                                                                                        insetForSection:UIEdgeInsetsZero
                                                                                              cellClass:@"HCCirculateScrollViewCell"];
    [cellInfoDictionary setObject:circulateScrollViewCellInfo forKey:@"topImgModule"];
    
    HCCollectionCellInfo *gridMenuViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kGridMenuCellIdentifier
                                                                                        sizeItem:CGSizeMake(screenWidth, screenWidth/320.0*192+1)
                                                                              minimumLineSpacing:0
                                                                          referenceSizeForHeader:CGSizeZero
                                                                                 insetForSection:UIEdgeInsetsZero
                                                                                       cellClass:@"HCGridMenuViewCell"];
    [cellInfoDictionary setObject:gridMenuViewCellInfo forKey:@"iconModule"];
    
    HCCollectionCellInfo *singlePageAdvertViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kSinglePageAdvertCellIdentifier
                                                                                                sizeItem:CGSizeMake(screenWidth, screenWidth/320.0*99)
                                                                                      minimumLineSpacing:0
                                                                                  referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                         insetForSection:UIEdgeInsetsZero
                                                                                               cellClass:@"SinglePageAdvertViewCell"];
    [cellInfoDictionary setObject:singlePageAdvertViewCellInfo forKey:@"bannerModule"];
    
    HCCollectionCellInfo *newUserFeastViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kNewUserFeastCellIdentifier
                                                                                            sizeItem:CGSizeMake(screenWidth, 43 + screenWidth/8.0*5 + screenWidth/320.0*174)
                                                                                  minimumLineSpacing:0
                                                                              referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                     insetForSection:UIEdgeInsetsZero
                                                                                           cellClass:@"NewUserFeastViewCell"];
    [cellInfoDictionary setObject:newUserFeastViewCellInfo forKey:@"newModule"];
    
    HCCollectionCellInfo *hotCategoryViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kHotCategoryViewCellIdentifier
                                                                                           sizeItem:CGSizeMake(screenWidth, 43 + screenWidth/320.0*374)
                                                                                 minimumLineSpacing:0
                                                                             referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                    insetForSection:UIEdgeInsetsZero
                                                                                          cellClass:@"HotCategoryViewCell"];
    [cellInfoDictionary setObject:hotCategoryViewCellInfo forKey:@"hotCateModule"];
    
    HCCollectionCellInfo *popularBrandsViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kPopularBrandsViewCellIdentifier
                                                                                             sizeItem:CGSizeMake(screenWidth, 43 + screenWidth/16.0*9)
                                                                                   minimumLineSpacing:0
                                                                               referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                      insetForSection:UIEdgeInsetsZero
                                                                                            cellClass:@"PopularBrandsViewCell"];
    [cellInfoDictionary setObject:popularBrandsViewCellInfo forKey:@"hotBrandModule"];
    
    HCCollectionCellInfo *fushionTrendViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kFushionTrendViewCellIdentifier
                                                                                            sizeItem:CGSizeMake(screenWidth, 43 + screenWidth/2.0)
                                                                                  minimumLineSpacing:0
                                                                              referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                     insetForSection:UIEdgeInsetsZero
                                                                                           cellClass:@"FushionTrendViewCell"];
    [cellInfoDictionary setObject:fushionTrendViewCellInfo forKey:@"colloSpecialModule"];
    
    HCCollectionCellInfo *shopTheLookViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kShopTheLookViewCellIdentifier
                                                                                           sizeItem:CGSizeMake(screenWidth, 43 + screenWidth/32.0*17)
                                                                                 minimumLineSpacing:0
                                                                             referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                    insetForSection:UIEdgeInsetsZero
                                                                                          cellClass:@"ShopTheLookViewCell"];
    [cellInfoDictionary setObject:shopTheLookViewCellInfo forKey:@"暂时获取不到Module"];
    
    HCCollectionCellInfo *magazineInfoViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kMagazineInfoViewCellIdentifier
                                                                                            sizeItem:CGSizeMake(screenWidth, 43 + screenWidth/40.0*23 + 61)
                                                                                  minimumLineSpacing:0
                                                                              referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                     insetForSection:UIEdgeInsetsZero
                                                                                           cellClass:@"MagazineInfoViewCell"];
    [cellInfoDictionary setObject:magazineInfoViewCellInfo forKey:@"imgModule"];
    
    HCCollectionCellInfo *wearTemplateViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kWearTemplateViewCellIdentifier
                                                                                            sizeItem:CGSizeMake(screenWidth, 43 + screenWidth/8.0*5 + screenWidth/32.0*17)
                                                                                  minimumLineSpacing:0
                                                                              referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                     insetForSection:UIEdgeInsetsZero
                                                                                           cellClass:@"WearTemplateViewCell"];
    [cellInfoDictionary setObject:wearTemplateViewCellInfo forKey:@"imgListV1Module"];
    
    CGFloat itemWidth = (screenWidth-30)/2.0;
    CGFloat itemHeight = itemWidth/145.0*85;
    HCCollectionCellInfo *doubleBannerViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kDoubleBannerViewCellIdentifier
                                                                                            sizeItem:CGSizeMake(screenWidth, itemHeight)
                                                                                  minimumLineSpacing:0
                                                                              referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                     insetForSection:UIEdgeInsetsZero
                                                                                           cellClass:@"DoubleBannerViewCell"];
    [cellInfoDictionary setObject:doubleBannerViewCellInfo forKey:@"imgListV3Module"];
    
    HCCollectionCellInfo *newJoinBrandViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kNewJoinBrandViewCellIdentifier
                                                                                            sizeItem:CGSizeMake(screenWidth, screenWidth/8.0*5 + screenWidth/32.0*23)
                                                                                  minimumLineSpacing:0
                                                                              referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                     insetForSection:UIEdgeInsetsZero
                                                                                           cellClass:@"NewJoinBrandViewCell"];
    [cellInfoDictionary setObject:newJoinBrandViewCellInfo forKey:@"imgListV4Module"];
    
    HCCollectionCellInfo *recommendedViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kRecommendedViewCellIdentifier
                                                                                           sizeItem:CGSizeMake(screenWidth, 43)
                                                                                 minimumLineSpacing:0
                                                                             referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                    insetForSection:UIEdgeInsetsZero
                                                                                          cellClass:@"RecommendedViewCell"];
    [cellInfoDictionary setObject:recommendedViewCellInfo forKey:@"likeModule"];
    
    CGFloat itemWidth01 = (screenWidth-30)/2.0;
    CGFloat itemHeight01 = itemWidth01 / 141.0 * 262;
    HCCollectionCellInfo *productShowBrandPriceCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kProductShowBrandPriceCellIdentifier
                                                                                                 sizeItem:CGSizeMake(itemWidth01, itemHeight01)
                                                                                       minimumLineSpacing:0
                                                                                   referenceSizeForHeader:CGSizeZero
                                                                                          insetForSection:UIEdgeInsetsMake(10, 10, 10, 10) cellClass:@"ProductShowBrandPriceCell"];
    [cellInfoDictionary setObject:productShowBrandPriceCellInfo forKey:@"likeProductModule"];
    
    _moudelDictionary = [cellInfoDictionary copy];
}

@end
