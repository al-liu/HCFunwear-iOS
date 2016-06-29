//
//  HomePageViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/5/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HomePageViewController.h"
#import "GlobalContext.h"

#import "UIImageView+YYWebImage.h"
#import "Masonry.h"
#import "HCCirculateScrollViewCell.h"
#import "HCGridMenuViewCell.h"
#import "SinglePageAdvertViewCell.h"

@interface HomePageViewController ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    HCCirculateScrollViewProtocol
>
{
    UICollectionView *_homePageCollectionView;
}

@end

#pragma mark - cell indentifier
static NSString *kCirculateScrollCellIdentifier = @"kCirculateScrollCellIdentifier";
static NSString *kGridMenuCellIdentifier = @"kGridMenuCellIdentifier";
static NSString *kSinglePageAdvertCellIdentifier = @"kSinglePageAdvertCellIdentifier";

@implementation HomePageViewController

#pragma mark - life_cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self initCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initUI
- (void)initCollectionView {
    UICollectionViewLayout *homePageCollectionLayout = [[UICollectionViewLayout alloc]init];
    
    _homePageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:homePageCollectionLayout];
    _homePageCollectionView.dataSource = self;
    _homePageCollectionView.delegate = self;
    [self.view addSubview:_homePageCollectionView];
    
    [_homePageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
    }];
    
    //注册 cell
    //广告轮播
    [_homePageCollectionView registerClass:[HCCirculateScrollViewCell class] forCellWithReuseIdentifier:kCirculateScrollCellIdentifier];
    //八宫格菜单
    [_homePageCollectionView registerClass:[HCGridMenuViewCell class] forCellWithReuseIdentifier:kGridMenuCellIdentifier];
    //单页广告
    [_homePageCollectionView registerClass:[SinglePageAdvertViewCell class] forCellWithReuseIdentifier:kSinglePageAdvertCellIdentifier];

    
}

#pragma mark - configration
- (void)configNavigationBar {
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 58);
    [leftButton setImage:[UIImage imageNamed:@"top_cebian"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 58, 0, 0);
    [rightButton setImage:[UIImage imageNamed:@"top_search"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [GlobalContext ShareInstance].mainTabBarController.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat screenWidth = screenSize.width;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//79"160
            return CGSizeMake(screenWidth, screenWidth/160.0*79);
        }
        else if (indexPath.row == 1) {//189"320
            return CGSizeMake(screenWidth, screenWidth/320.0*189);
        }
        else if (indexPath.row == 2) {//99:320
            return CGSizeMake(screenWidth, screenWidth/320.0*99);
        }
    }
    return CGSizeZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

/*
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}
 */
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HCCirculateScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCirculateScrollCellIdentifier forIndexPath:indexPath];
            return cell;
        }
        else if (indexPath.row == 1) {
            HCGridMenuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGridMenuCellIdentifier forIndexPath:indexPath];
            return cell;
        }
    }
    else if (indexPath.section == 1) {
        SinglePageAdvertViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSinglePageAdvertCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    return nil;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
