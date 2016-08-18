//
//  HomePageView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/16.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HomePageView.h"
#import "UIImageView+YYWebImage.h"
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
#import "Masonry.h"
#import "GlobalConstant.h"
#import "GlobalColors.h"
#import "HCModule.h"
#import "HCModuleData.h"
#import "HCCollectionCellInfo.h"
#import "RACEXTScope.h"
#import "HCFunwearRefreshHeader.h"
#import "HCFunwearRefreshFooter.h"

#pragma mark - cell indentifier
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

@interface HomePageView ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
HCCirculateScrollViewProtocol
>

@end
@implementation HomePageView {
    UICollectionView *_homePageCollectionView;
    NSDictionary *_moudelDictionary;
    NSMutableArray *_guessLikeProducts;
}

- (instancetype)initWithViewModel:(HomePageViewModel *)mdoel {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _homePageViewModel = mdoel;
        _guessLikeProducts = [NSMutableArray array];
        [self initCollectionView];
    }
    return self;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCollectionView];
        _guessLikeProducts = [NSMutableArray array];
    }
    return self;
}
- (void)reloadData {
    [_homePageCollectionView reloadData];
}

- (void)setHomePageDataList:(NSArray *)homePageDataList {
    HCModule *lastModule = homePageDataList.lastObject;
    if ([lastModule.module_key isEqualToString:@"likeProductModule"]) {
        _homePageDataList = homePageDataList;
    }
    else {
        HCModule *likeModule = [[HCModule alloc]init];
        likeModule.module_id = @"-1";
        likeModule.c_title = @"猜你喜欢";
        likeModule.e_title = @"";
        likeModule.module_key = @"likeProductModule";
        
        NSMutableArray *mutableArray = [homePageDataList mutableCopy];
        [mutableArray addObject:likeModule];
        _homePageDataList = [mutableArray copy];
    }
}

- (void)initCollectionView {
    UICollectionViewFlowLayout *homePageCollectionLayout = [[UICollectionViewFlowLayout alloc]init];
    
    _homePageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:homePageCollectionLayout];
    _homePageCollectionView.dataSource = self;
    _homePageCollectionView.delegate = self;
    _homePageCollectionView.backgroundColor = [UIColor whiteColor];//kCommonColor
    [self addSubview:_homePageCollectionView];
    
    [_homePageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //注册 cell
    [self registerCollectionCells];
    [self registerCollectionCellsInfo];
    
    _homePageCollectionView.mj_header = [HCFunwearRefreshHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [_homePageCollectionView.mj_header endRefreshing];
        });
    }];
    
    _homePageCollectionView.mj_footer = [HCFunwearRefreshFooter footerWithRefreshingBlock:^{
        RACSignal *productsRequestSignal = [_homePageViewModel.productsRequestCommand execute:nil];
        [productsRequestSignal subscribeNext:^(NSArray *productList) {
            NSLog(@"product:%@",productList);
            [_guessLikeProducts addObjectsFromArray:productList];
            //看下能不能只刷新一组数据
//            [_homePageCollectionView reload]
            _homePageViewModel.productsPage += 1;
            [_homePageCollectionView reloadData];
             [_homePageCollectionView.mj_footer endRefreshing];
        }];
    }];
}

- (void)registerCollectionCells {
    //广告轮播
    [_homePageCollectionView registerClass:[HCCirculateScrollViewCell class]
                forCellWithReuseIdentifier:kCirculateScrollCellIdentifier];
    //八宫格菜单
    [_homePageCollectionView registerClass:[HCGridMenuViewCell class]
                forCellWithReuseIdentifier:kGridMenuCellIdentifier];
    //单页广告
    [_homePageCollectionView registerClass:[SinglePageAdvertViewCell class]
                forCellWithReuseIdentifier:kSinglePageAdvertCellIdentifier];
    //新手专享
    [_homePageCollectionView registerClass:[NewUserFeastViewCell class]
                forCellWithReuseIdentifier:kNewUserFeastCellIdentifier];
    //热门品类
    [_homePageCollectionView registerClass:[HotCategoryViewCell class]
                forCellWithReuseIdentifier:kHotCategoryViewCellIdentifier];
    //热门品牌
    [_homePageCollectionView registerClass:[PopularBrandsViewCell class]
                forCellWithReuseIdentifier:kPopularBrandsViewCellIdentifier];
    //搭配趋势
    [_homePageCollectionView registerClass:[FushionTrendViewCell class]
                forCellWithReuseIdentifier:kFushionTrendViewCellIdentifier];
    //限时搭配购
    [_homePageCollectionView registerClass:[ShopTheLookViewCell class]
                forCellWithReuseIdentifier:kShopTheLookViewCellIdentifier];
    //流行资讯
    [_homePageCollectionView registerClass:[MagazineInfoViewCell class]
                forCellWithReuseIdentifier:kMagazineInfoViewCellIdentifier];
    //穿戴:上装，下装，鞋履，包袋，配饰，男士护理，户外运动
    [_homePageCollectionView registerClass:[WearTemplateViewCell class]
                forCellWithReuseIdentifier:kWearTemplateViewCellIdentifier];
    //两个广告栏
    [_homePageCollectionView registerClass:[DoubleBannerViewCell class]
                forCellWithReuseIdentifier:kDoubleBannerViewCellIdentifier];
    //新入住品牌
    [_homePageCollectionView registerClass:[NewJoinBrandViewCell class]
                forCellWithReuseIdentifier:kNewJoinBrandViewCellIdentifier];
    //猜你喜欢头标题
    [_homePageCollectionView registerClass:[RecommendedViewCell class]
                forCellWithReuseIdentifier:kRecommendedViewCellIdentifier];
    //猜你喜欢产品
    [_homePageCollectionView registerNib:[UINib nibWithNibName:@"ProductShowBrandPriceCell" bundle:nil]
              forCellWithReuseIdentifier:kProductShowBrandPriceCellIdentifier];
    //首页常用组头Head
    [_homePageCollectionView registerClass:[HomePageHeadReusableView class]
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
                                                                                        insetForSection:UIEdgeInsetsZero];
    [cellInfoDictionary setObject:circulateScrollViewCellInfo forKey:@"topImgModule"];
    HCCollectionCellInfo *gridMenuViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kGridMenuCellIdentifier
                                                                                        sizeItem:CGSizeMake(screenWidth, screenWidth/320.0*192+1)
                                                                              minimumLineSpacing:0
                                                                          referenceSizeForHeader:CGSizeZero
                                                                                 insetForSection:UIEdgeInsetsZero];
    [cellInfoDictionary setObject:gridMenuViewCellInfo forKey:@"iconModule"];
    HCCollectionCellInfo *singlePageAdvertViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kSinglePageAdvertCellIdentifier
                                                                                                sizeItem:CGSizeMake(screenWidth, screenWidth/320.0*99)
                                                                                      minimumLineSpacing:0
                                                                                  referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                         insetForSection:UIEdgeInsetsZero];
    [cellInfoDictionary setObject:singlePageAdvertViewCellInfo forKey:@"bannerModule"];
    HCCollectionCellInfo *newUserFeastViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kNewUserFeastCellIdentifier
                                                                                            sizeItem:CGSizeMake(screenWidth, 43 + screenWidth/8.0*5 + screenWidth/320.0*174)
                                                                                  minimumLineSpacing:0
                                                                              referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                     insetForSection:UIEdgeInsetsZero];
    [cellInfoDictionary setObject:newUserFeastViewCellInfo forKey:@"newModule"];
    HCCollectionCellInfo *hotCategoryViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kHotCategoryViewCellIdentifier
                                                                                           sizeItem:CGSizeMake(screenWidth, 43 + screenWidth/320.0*374)
                                                                                 minimumLineSpacing:0
                                                                             referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                    insetForSection:UIEdgeInsetsZero];
    [cellInfoDictionary setObject:hotCategoryViewCellInfo forKey:@"hotCateModule"];
    HCCollectionCellInfo *popularBrandsViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kPopularBrandsViewCellIdentifier
                                                                                             sizeItem:CGSizeMake(screenWidth, 43 + screenWidth/16.0*9)
                                                                                   minimumLineSpacing:0
                                                                               referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                      insetForSection:UIEdgeInsetsZero];
    [cellInfoDictionary setObject:popularBrandsViewCellInfo forKey:@"hotBrandModule"];
    HCCollectionCellInfo *fushionTrendViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kFushionTrendViewCellIdentifier
                                                                                            sizeItem:CGSizeMake(screenWidth, 43 + screenWidth/2.0)
                                                                                  minimumLineSpacing:0
                                                                              referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                     insetForSection:UIEdgeInsetsZero];
    [cellInfoDictionary setObject:fushionTrendViewCellInfo forKey:@"colloSpecialModule"];
    HCCollectionCellInfo *shopTheLookViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kShopTheLookViewCellIdentifier
                                                                                           sizeItem:CGSizeMake(screenWidth, 43 + screenWidth/32.0*17)
                                                                                 minimumLineSpacing:0
                                                                             referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                    insetForSection:UIEdgeInsetsZero];
    [cellInfoDictionary setObject:shopTheLookViewCellInfo forKey:@"暂时获取不到Module"];
    HCCollectionCellInfo *magazineInfoViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kMagazineInfoViewCellIdentifier
                                                                                            sizeItem:CGSizeMake(screenWidth, 43 + screenWidth/40.0*23 + 61)
                                                                                  minimumLineSpacing:0
                                                                              referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                     insetForSection:UIEdgeInsetsZero];
    [cellInfoDictionary setObject:magazineInfoViewCellInfo forKey:@"imgModule"];
    HCCollectionCellInfo *wearTemplateViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kWearTemplateViewCellIdentifier
                                                                                            sizeItem:CGSizeMake(screenWidth, 43 + screenWidth/8.0*5 + screenWidth/32.0*17)
                                                                                  minimumLineSpacing:0
                                                                              referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                     insetForSection:UIEdgeInsetsZero];
    [cellInfoDictionary setObject:wearTemplateViewCellInfo forKey:@"imgListV1Module"];
    CGFloat itemWidth = (screenWidth-30)/2.0;
    CGFloat itemHeight = itemWidth/145.0*85;
    HCCollectionCellInfo *doubleBannerViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kDoubleBannerViewCellIdentifier
                                                                                            sizeItem:CGSizeMake(screenWidth, itemHeight)
                                                                                  minimumLineSpacing:0
                                                                              referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                     insetForSection:UIEdgeInsetsZero];
    [cellInfoDictionary setObject:doubleBannerViewCellInfo forKey:@"imgListV3Module"];
    HCCollectionCellInfo *newJoinBrandViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kNewJoinBrandViewCellIdentifier
                                                                                            sizeItem:CGSizeMake(screenWidth, screenWidth/8.0*5 + screenWidth/32.0*23)
                                                                                  minimumLineSpacing:0
                                                                              referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                     insetForSection:UIEdgeInsetsZero];
    [cellInfoDictionary setObject:newJoinBrandViewCellInfo forKey:@"imgListV4Module"];
    HCCollectionCellInfo *recommendedViewCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kRecommendedViewCellIdentifier
                                                                                           sizeItem:CGSizeMake(screenWidth, 43)
                                                                                 minimumLineSpacing:0
                                                                             referenceSizeForHeader:CGSizeMake(screenWidth, 10)
                                                                                    insetForSection:UIEdgeInsetsZero];
    [cellInfoDictionary setObject:recommendedViewCellInfo forKey:@"likeModule"];
    CGFloat itemWidth01 = (screenWidth-30)/2.0;
    CGFloat itemHeight01 = itemWidth01 / 141.0 * 262;
    HCCollectionCellInfo *productShowBrandPriceCellInfo = [[HCCollectionCellInfo alloc]initWithIdentifier:kProductShowBrandPriceCellIdentifier
                                                                                           sizeItem:CGSizeMake(itemWidth01, itemHeight01)
                                                                                 minimumLineSpacing:0
                                                                             referenceSizeForHeader:CGSizeZero
                                                                                    insetForSection:UIEdgeInsetsMake(10, 10, 10, 10)];
    [cellInfoDictionary setObject:productShowBrandPriceCellInfo forKey:@"likeProductModule"];
    _moudelDictionary = [cellInfoDictionary copy];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    HCModule *module = _homePageDataList[indexPath.section];
    HCCollectionCellInfo *info = _moudelDictionary[module.module_key];
    return info.sizeItem;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    HCModule *module = _homePageDataList[section];
    HCCollectionCellInfo *info = _moudelDictionary[module.module_key];
    return info.minimumLineSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    HCModule *module = _homePageDataList[section];
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
    if (section == _homePageDataList.count-1) {//猜你喜欢产品的组
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    HCModule *module = _homePageDataList[section];
    HCCollectionCellInfo *info = _moudelDictionary[module.module_key];
    return info.insetForSection;
//    return UIEdgeInsetsZero;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _homePageDataList.count;//猜你喜欢
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == _homePageDataList.count-1) {//猜你喜欢产品的组
        return _guessLikeProducts.count;
    }
    return 1;
}
#warning home page limit time without moudle key 在现有的接口返回的数据里看不到 限时搭配购的 moudle key
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HCModule *module = _homePageDataList[indexPath.section];
    HCCollectionCellInfo *info = _moudelDictionary[module.module_key];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:info.identifier forIndexPath:indexPath];
    if ([module.module_key isEqualToString:@"topImgModule"]) {
        HCCirculateScrollViewCell *circulateCell = (HCCirculateScrollViewCell *)cell;
        NSArray *urlStrings = [[module.data.rac_sequence map:^id(HCModuleData *value) {
            return value.img;
        }] array];
        [circulateCell.circulateScrollView loadView:urlStrings];
    }
    else if ([module.module_key isEqualToString:@"iconModule"]) {
        HCGridMenuViewCell *gridMenuCell = (HCGridMenuViewCell *)cell;
        [gridMenuCell.gridMenuView reloadDataWithTypes:module.data];
    }
    else if ([module.module_key isEqualToString:@"bannerModule"]) {
        SinglePageAdvertViewCell *singleAdvertCell = (SinglePageAdvertViewCell *)cell;
        HCModuleData *moudleData = module.data.firstObject;
        @weakify(singleAdvertCell);
        [singleAdvertCell.advertView setImageWithURL:moudleData.img placeholder:nil options:YYWebImageOptionAvoidSetImage completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            @strongify(singleAdvertCell)
            singleAdvertCell.advertView.image = image;
            singleAdvertCell.advertView.contentMode = UIViewContentModeScaleAspectFit;
        }];
    }
    else if ([module.module_key isEqualToString:@"newModule"]) {
        NewUserFeastViewCell *userFeastCell = (NewUserFeastViewCell *)cell;
        userFeastCell.feastView.userFeastModule = module;
        [userFeastCell.feastView reloadData];
    }
    else if ([module.module_key isEqualToString:@"hotCateModule"]) {
        HotCategoryViewCell *hotCategoryCell = (HotCategoryViewCell *)cell;
        hotCategoryCell.hotGategoryView.hotCategoryModule = module;
        [hotCategoryCell.hotGategoryView reloadData];
    }
    else if ([module.module_key isEqualToString:@"hotBrandModule"]) {
        PopularBrandsViewCell *popularBrandsCell = (PopularBrandsViewCell *)cell;
        popularBrandsCell.brandsView.popularModule = module;
        [popularBrandsCell.brandsView reloadData];
    }
    else if ([module.module_key isEqualToString:@"colloSpecialModule"]) {
        FushionTrendViewCell *funshionCell = (FushionTrendViewCell *)cell;
        funshionCell.fushionTrendView.module = module;
        [funshionCell.fushionTrendView reloadData];
    }
    else if ([module.module_key isEqualToString:@"imgModule"]) {
        MagazineInfoViewCell *newCell = (MagazineInfoViewCell *)cell;
        newCell.magazineInfoView.module = module;
        [newCell.magazineInfoView reloadData];
    }
    else if ([module.module_key isEqualToString:@"imgListV1Module"]) {
        WearTemplateViewCell *newCell = (WearTemplateViewCell *)cell;
        newCell.wearTemplateView.module = module;
        [newCell.wearTemplateView reloadData];
    }
    else if ([module.module_key isEqualToString:@"imgListV3Module"]) {
        DoubleBannerViewCell *newCell = (DoubleBannerViewCell *)cell;
        newCell.doubleBannerView.module = module;
        [newCell.doubleBannerView reloadData];
    }
    else if ([module.module_key isEqualToString:@"imgListV4Module"]) {
        NewJoinBrandViewCell *newCell = (NewJoinBrandViewCell *)cell;
        newCell.joinBrandView.module = module;
        [newCell.joinBrandView reloadData];
    }
    else if ([module.module_key isEqualToString:@"likeModule"]) {
        RecommendedViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRecommendedViewCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if ([module.module_key isEqualToString:@"likeProductModule"]) {
        ProductShowBrandPriceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kProductShowBrandPriceCellIdentifier forIndexPath:indexPath];
        cell.product = _guessLikeProducts[indexPath.row];
        return cell;
    }
    
    
    return cell;
    /*
    if (indexPath.section == 0) {
        HCCirculateScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCirculateScrollCellIdentifier forIndexPath:indexPath];
        HCModule *topImgModule = _homePageDataList[0];
        NSArray *urlStrings = [[topImgModule.data.rac_sequence map:^id(HCModuleData *value) {
            return value.img;
        }] array];
        [cell.circulateScrollView loadView:urlStrings];
        return cell;
    }
    else if (indexPath.section == 1) {
        HCGridMenuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGridMenuCellIdentifier forIndexPath:indexPath];
        HCModule *iconModule = _homePageDataList[1];
        [cell.gridMenuView reloadDataWithTypes:iconModule.data];
        //            [cell.gridMenuView reloadDataWithTypes:_homePageViewModel.gridMenuArray];
        return cell;
    }
    else if (indexPath.section == 2) {
        SinglePageAdvertViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSinglePageAdvertCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 3) {
        NewUserFeastViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNewUserFeastCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 4) {
        HotCategoryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHotCategoryViewCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 5) {
        PopularBrandsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPopularBrandsViewCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 6) {
        FushionTrendViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFushionTrendViewCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 7) {//暂时没有在接口中看到
        ShopTheLookViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kShopTheLookViewCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 8) {
        MagazineInfoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMagazineInfoViewCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 9 || indexPath.section == 10 || indexPath.section == 11 || indexPath.section == 12 || indexPath.section == 13 || indexPath.section == 14 || indexPath.section == 15) {
        WearTemplateViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWearTemplateViewCellIdentifier forIndexPath:indexPath];
        cell.wearTemplateView.headTitleView.headModel = _homePageViewModel.headTitleArray[indexPath.section-8];
        return cell;
    }
    else if (indexPath.section == 16) {
        DoubleBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDoubleBannerViewCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 17) {
        NewJoinBrandViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNewJoinBrandViewCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 18) {
        RecommendedViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRecommendedViewCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 19) {
        ProductShowBrandPriceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kProductShowBrandPriceCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    return nil;
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

#pragma mark - HCCirculateScrollViewProtocol # 广告轮播 #
- (void)circulateScrollView:(HCCirculateScrollView *)circulateSctollView
               loadImageUrl:(NSURL *)url
              withImageView:(UIImageView *)imageView {
    [imageView setImageWithURL:url placeholder:[UIImage imageNamed:@"fan_default_01"]];
}

- (void)circulateScrollViewDidSelectedAtIndex:(NSInteger)index {
    
}

- (void)circulateScrollViewPageControlAtIndex:(NSInteger)index {
    
}

@end
