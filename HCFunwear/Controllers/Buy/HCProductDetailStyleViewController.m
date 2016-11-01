//
//  HCProductDetailStyleViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCProductDetailStyleViewController.h"
#import "ProductDetailStyleView.h"
#import "Masonry.h"
#import "GlobalImport.h"
#import "UIColor+YYAdd.h"

#import "HCGoodsKindTagCell.h"
#import "HCGoodsKindTagKindHeaderView.h"
#import "HCGoodsKindSelectFooterView.h"

static NSString *kHCGoodsKindTagCellId = @"HCGoodsKindTagCellId";
static NSString *kHCGoodsKindTagKindHeaderId = @"HCGoodsKindTagKindHeaderId";
static NSString *kHCGoodsKindSelectFooterId = @"HCGoodsKindSelectFooterId";

@interface HCProductDetailStyleViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *_datas;
    CGSize _defaultItemSize;
    
    //color size 实际上会做成模型
    NSMutableDictionary *_goodsStyleInfo;
    
    NSIndexPath *_colorSelectedIndexPath;
    NSIndexPath *_sizeSelectedIndexPath;
}

@property (nonatomic, strong) HCProductDetailStyleViewModel *productDetailStyleViewModel;

@end

@implementation HCProductDetailStyleViewController

- (instancetype)initWithViewModel:(HCProductDetailStyleViewModel *)viewModel {
    self = [super init];
    if (self) {
        _productDetailStyleViewModel = viewModel;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //商品信息
    ProductDetailStyleView *detailStyleView = [ProductDetailStyleView new];
    [self.view addSubview:detailStyleView];
    
    [detailStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@104);
    }];
    
    //底部确定按钮
    CGFloat bottom = SCREEN_HEIGHT * 0.31;
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.backgroundColor = [UIColor colorWithHexString:@"#262626"];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:submitButton];
    
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@44);
        make.bottom.equalTo(self.view).offset(-bottom);
    }];
    
    //商品类型
    // 初始化一些数据
    _datas = @[@{@"title":@"颜色",@"tags":@[@"深蓝/白色/超级黑",@"非常白/超级蓝",@"很黄",@"很暴力",@"很漂亮",@"阿尔法"]},
               @{@"title":@"尺寸",@"tags":@[@"170/85A",@"171/85A",@"172/85A",@"173/85A",@"174/85A",@"175/85A",@"176/85A"]}];
    
    CGSize screen_size = [UIScreen mainScreen].bounds.size;
    
    CGFloat estimatedItemWidth = (screen_size.width - 5 * 10)/4;
    CGFloat estimatedItemHeith = 24;
    _defaultItemSize = CGSizeMake(estimatedItemWidth, estimatedItemHeith);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    flowLayout.headerReferenceSize = CGSizeMake(screen_size.width, 37);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.allowsMultipleSelection = YES;
    [self.view addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(detailStyleView.mas_bottom);
        make.bottom.equalTo(submitButton.mas_top);
    }];
    
    [collectionView registerNib:[UINib nibWithNibName:@"HCGoodsKindTagCell" bundle:nil]
     forCellWithReuseIdentifier:kHCGoodsKindTagCellId];
    [collectionView registerNib:[UINib nibWithNibName:@"HCGoodsKindTagKindHeaderView" bundle:nil]
     forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            withReuseIdentifier:kHCGoodsKindTagKindHeaderId];
    [collectionView registerNib:[UINib nibWithNibName:@"HCGoodsKindSelectFooterView" bundle:nil]
     forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
            withReuseIdentifier:kHCGoodsKindSelectFooterId];
    
    _colorSelectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    _sizeSelectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [collectionView selectItemAtIndexPath:_colorSelectedIndexPath
                                 animated:NO
                           scrollPosition:UICollectionViewScrollPositionNone];
    [collectionView selectItemAtIndexPath:_sizeSelectedIndexPath
                                 animated:NO
                           scrollPosition:UICollectionViewScrollPositionNone];
    NSString *defaultColorString = _datas[_colorSelectedIndexPath.section][@"tags"][_colorSelectedIndexPath.row];
    NSString *defaultSizeString = _datas[_sizeSelectedIndexPath.section][@"tags"][_sizeSelectedIndexPath.row];
    _goodsStyleInfo = [[NSMutableDictionary alloc]initWithDictionary:@{@"color":defaultColorString,@"size":defaultSizeString}];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *tags = _datas[section][@"tags"];
    return tags.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HCGoodsKindTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHCGoodsKindTagCellId forIndexPath:indexPath];
    cell.tagLabel.text = _datas[indexPath.section][@"tags"][indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HCGoodsKindTagKindHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHCGoodsKindTagKindHeaderId forIndexPath:indexPath];
        header.kindTitleLabel.text = _datas[indexPath.section][@"title"];
        return header;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        HCGoodsKindSelectFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kHCGoodsKindSelectFooterId forIndexPath:indexPath];
        return footer;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *value = _datas[indexPath.section][@"tags"][indexPath.row];
    switch (indexPath.section) {
        case 0:
        {
            if ([value isEqualToString:_goodsStyleInfo[@"color"]]) {
                return NO;
            }
            else {
                return YES;
            }
        }
            break;
        case 1:
            if ([value isEqualToString:_goodsStyleInfo[@"size"]]) {
                return NO;
            }
            else {
                return YES;
            }
        default:
            break;
    }
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中了 第 %ld 组 第 %ld 个",indexPath.section,indexPath.row);
    NSString *value = _datas[indexPath.section][@"tags"][indexPath.row];
    switch (indexPath.section) {
        case 0:
            [_goodsStyleInfo setObject:value forKey:@"color"];
            [collectionView deselectItemAtIndexPath:_colorSelectedIndexPath animated:NO];
            _colorSelectedIndexPath = indexPath;
            break;
        case 1:
            [_goodsStyleInfo setObject:value forKey:@"size"];
            [collectionView deselectItemAtIndexPath:_sizeSelectedIndexPath animated:NO];
            _sizeSelectedIndexPath = indexPath;
        default:
            break;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //计算暂时在这里做
    NSString *tagString = _datas[indexPath.section][@"tags"][indexPath.row];
    CGRect tagRect = [tagString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, _defaultItemSize.height)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}
                                             context:nil];
    CGFloat countItemWidth = tagRect.size.width + 10;
    CGFloat itemWidth = countItemWidth > _defaultItemSize.width ? (countItemWidth + 10) : _defaultItemSize.width;
    return CGSizeMake(itemWidth , _defaultItemSize.height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 1) {
        CGSize screen_size = [UIScreen mainScreen].bounds.size;
        return CGSizeMake(screen_size.width, 66);
    }
    return CGSizeZero;
}

@end
