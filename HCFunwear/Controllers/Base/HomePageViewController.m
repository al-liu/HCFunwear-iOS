//
//  HomePageViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/5/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HomePageViewController.h"
#import "GlobalContext.h"

#import "HCCirculateScrollView.h"
#import "UIImageView+YYWebImage.h"
#import "Masonry.h"

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

@implementation HomePageViewController

#pragma mark - life_cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //WithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 200)
    HCCirculateScrollView *scrollView = [[HCCirculateScrollView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 200)];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    
//    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@60);
//        make.left.right.equalTo(self.view);
//        make.height.equalTo(@200);
//    }];
    
    NSArray *urlStringList = @[@"http://i2.chinanews.com/simg/2016/160624//56925620.jpg",
                               @"http://i3.hexunimg.cn/2016-06-26/184596032.jpg",
                               @"http://n.sinaimg.cn/mil/transform/20160625/OJrJ-fxtniax7896757.jpg"];
    
    [scrollView loadView:urlStringList];
    scrollView.isAutomatic = YES;
}
- (void)circulateScrollView:(HCCirculateScrollView *)circulateSctollView
               loadImageUrl:(NSURL *)url
              withImageView:(UIImageView *)imageView {
    [imageView setImageURL:url];
    NSLog(@"loadImageUrl");
}
- (void)circulateScrollViewDidSelectedAtIndex:(NSInteger)index {
    NSLog(@"DidSelectedAtIndex:%ld",index);
}
- (void)circulateScrollViewPageControlAtIndex:(NSInteger)index {
    NSLog(@"PageControlAtInde:%ld",index);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
//    [self initCollectionView];
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
    
    return CGSizeZero;
}
/*
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {    return 0;
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
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
