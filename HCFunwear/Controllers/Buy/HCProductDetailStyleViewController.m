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
#import "HCGoodsKindModel.h"

static NSString *kHCGoodsKindTagCellId = @"HCGoodsKindTagCellId";
static NSString *kHCGoodsKindTagKindHeaderId = @"HCGoodsKindTagKindHeaderId";
static NSString *kHCGoodsKindSelectFooterId = @"HCGoodsKindSelectFooterId";

@interface HCProductDetailStyleViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    CGSize _defaultItemSize;
    
    //color size 实际上会做成模型
    NSMutableDictionary *_goodsStyleInfo;
    
    NSInteger _colorSelectedIndex;
    NSInteger _sizeSelectedIndex;
    
    UICollectionView *_collectionView;
    HCGoodsKindSelectFooterView *_footerView;
    ProductDetailStyleView *_detailStyleView;
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
    [self initUI];
    
    @weakify(self);
    [_productDetailStyleViewModel.requestCommand execute:nil];
    [[RACObserve(_productDetailStyleViewModel, goodsKindList) skip:1] subscribeNext:^(id x) {
        @strongify(self);
        [self->_collectionView reloadData];
        _colorSelectedIndex = 0;
        _sizeSelectedIndex = 0;
        
        HCGoodsKindModel *kindModel = _productDetailStyleViewModel.goodsKindList[_colorSelectedIndex];
        //更新产品图片
        [_detailStyleView updateProductImage:kindModel.coloR_FILE_PATH];
        HCGoodsKindSizeModel *sizeModel = kindModel.sizeList.firstObject;
        [self setFooterDataWith:sizeModel];
        
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:_colorSelectedIndex inSection:0]
                                      animated:NO
                                scrollPosition:UICollectionViewScrollPositionNone];
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:_sizeSelectedIndex inSection:1]
                                      animated:NO
                                scrollPosition:UICollectionViewScrollPositionNone];
    }];
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    //商品信息
    _detailStyleView = [ProductDetailStyleView new];
    [self.view addSubview:_detailStyleView];
    
    [_detailStyleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@104);
    }];
    
    [_detailStyleView bindViewModel:_productDetailStyleViewModel];
    
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
    CGSize screen_size = [UIScreen mainScreen].bounds.size;
    
    CGFloat estimatedItemWidth = (screen_size.width - 5 * 10)/4;
    CGFloat estimatedItemHeith = 24;
    _defaultItemSize = CGSizeMake(estimatedItemWidth, estimatedItemHeith);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    flowLayout.headerReferenceSize = CGSizeMake(screen_size.width, 37);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.allowsMultipleSelection = YES;
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_detailStyleView.mas_bottom);
        make.bottom.equalTo(submitButton.mas_top);
    }];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"HCGoodsKindTagCell" bundle:nil]
     forCellWithReuseIdentifier:kHCGoodsKindTagCellId];
    [_collectionView registerNib:[UINib nibWithNibName:@"HCGoodsKindTagKindHeaderView" bundle:nil]
     forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            withReuseIdentifier:kHCGoodsKindTagKindHeaderId];
    [_collectionView registerNib:[UINib nibWithNibName:@"HCGoodsKindSelectFooterView" bundle:nil]
     forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
            withReuseIdentifier:kHCGoodsKindSelectFooterId];
    
    
    
//    NSString *defaultColorString = _datas[_colorSelectedIndexPath.section][@"tags"][_colorSelectedIndexPath.row];
//    NSString *defaultSizeString = _datas[_sizeSelectedIndexPath.section][@"tags"][_sizeSelectedIndexPath.row];
//    _goodsStyleInfo = [[NSMutableDictionary alloc]initWithDictionary:@{@"color":defaultColorString,@"size":defaultSizeString}];
}

- (void)setFooterDataWith:(HCGoodsKindSizeModel *)sizeModel {
    _footerView.stockAmountLabel.text = [NSString stringWithFormat:@"库存%@件",sizeModel.lisT_QTY];
    [_footerView.counterView resetCount:1];
    _footerView.counterView.minCount = 1;
    _footerView.counterView.maxCount = [sizeModel.lisT_QTY integerValue];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return _productDetailStyleViewModel.goodsKindList.count;
    }
    HCGoodsKindModel *kindModel = _productDetailStyleViewModel.goodsKindList[_colorSelectedIndex];
    return kindModel.sizeList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HCGoodsKindTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHCGoodsKindTagCellId forIndexPath:indexPath];
    if (indexPath.section == 0) {
        HCGoodsKindModel *kindModel = _productDetailStyleViewModel.goodsKindList[indexPath.row];
        cell.tagLabel.text = kindModel.coloR_NAME;
    }
    else if (indexPath.section == 1) {
        HCGoodsKindModel *kindModel = _productDetailStyleViewModel.goodsKindList[_colorSelectedIndex];
        HCGoodsKindSizeModel *sizeModel = kindModel.sizeList[indexPath.row];
        cell.tagLabel.text = sizeModel.speC_NAME;
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HCGoodsKindTagKindHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHCGoodsKindTagKindHeaderId forIndexPath:indexPath];
        if (indexPath.section == 0) {
            header.kindTitleLabel.text = @"颜色";
        }
        else if (indexPath.section == 1) {
            header.kindTitleLabel.text = @"尺寸";
        }
        
        return header;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        _footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kHCGoodsKindSelectFooterId forIndexPath:indexPath];
        HCGoodsKindModel *kindModel = _productDetailStyleViewModel.goodsKindList[_colorSelectedIndex];
        HCGoodsKindSizeModel *sizeModel = kindModel.sizeList[_sizeSelectedIndex];
        //设置库存
        [self setFooterDataWith:sizeModel];
        return _footerView;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == _colorSelectedIndex) {
                return NO;
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == _sizeSelectedIndex) {
                return NO;
            }
        }
            break;
            
        default:
            break;
    }
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            //取出 Kind
            HCGoodsKindModel *kindModel = _productDetailStyleViewModel.goodsKindList[indexPath.row];
            
            //更新产品图片
            [_detailStyleView updateProductImage:kindModel.coloR_FILE_PATH];
            HCGoodsKindSizeModel *sizeModel = kindModel.sizeList.firstObject;
            [self setFooterDataWith:sizeModel];
            
            [collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForRow:_colorSelectedIndex inSection:0] animated:NO];
            _colorSelectedIndex = indexPath.row;
            _sizeSelectedIndex = 0;
            //刷新 size 组
            [collectionView reloadSections:[[NSIndexSet alloc] initWithIndex:1]];
            [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:_sizeSelectedIndex inSection:1] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        }
            break;
        case 1:
        {
            //取出 Size
            HCGoodsKindModel *kindModel = _productDetailStyleViewModel.goodsKindList[_colorSelectedIndex];
            HCGoodsKindSizeModel *sizeModel = kindModel.sizeList[indexPath.row];
            
            //设置库存
           [self setFooterDataWith:sizeModel];
            
            [collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForRow:_sizeSelectedIndex inSection:1] animated:NO];
            _sizeSelectedIndex = indexPath.row;
        }
        default:
            break;
    }
    
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat countItemWidth = 0;
    if (indexPath.section == 0) {
        HCGoodsKindModel *kindModel = _productDetailStyleViewModel.goodsKindList[indexPath.row];
        countItemWidth = kindModel.color_tag_width;
    }
    else if (indexPath.section == 1) {
        HCGoodsKindModel *kindModel = _productDetailStyleViewModel.goodsKindList[_colorSelectedIndex];
        HCGoodsKindSizeModel *sizeModel = kindModel.sizeList[indexPath.row];
        countItemWidth = sizeModel.spec_tag_width;
    }

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
