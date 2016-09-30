//
//  HCAppraiseNoReplyCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/30.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCAppraiseNoReplyCell.h"
#import "Masonry.h"
#import "GlobalColors.h"
#import "SingleImageCell.h"
#import "GlobalConstant.h"
#import "UIColor+YYAdd.h"
#import "HCCommentListModel.h"
#import "UIImageView+HCPackWebImage.h"

@interface HCAppraiseNoReplyCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIImageView *_headImageView;
    UILabel *_userNameLabel;
    UILabel *_timestampLabel;
    UILabel *_appraiseContentLabel;
    UILabel *_colorSizeLabel;
    UICollectionView *_photoCollevtionView;
    
    HCCommentListSubsModel *_sub;
}

@property (nonatomic,strong)NSArray *imageList;
@end

@implementation HCAppraiseNoReplyCell

- (void)setData:(HCCommentListModel *)model {
    _userNameLabel.text = model.nick_name;
    _timestampLabel.text = model.create_time;
    _appraiseContentLabel.text = model.info;
    
    if (![model.product_color isEqualToString:@""]&&![model.product_size isEqualToString:@""]) {
        _colorSizeLabel.text = [NSString stringWithFormat:@"颜色：%@ 尺寸：%@",model.product_color,model.product_size];
    }

    _imageList = model.img_list;
    if (_imageList.count != 0) {
        [_photoCollevtionView reloadData];
    }
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}


- (void)initUI {
    //头像
    _headImageView = ({
        UIImageView *view = [UIImageView new];
        view.image = [UIImage imageNamed:@"default_head"];
        [self.contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(15);
            make.width.height.equalTo(@30);
        }];
        
        view;
    });
    
    //多少天前
    _timestampLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = kTextColor404;
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(_headImageView);
            make.height.equalTo(@12);
        }];
        
        label;
    });
    
    [_timestampLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                     forAxis:UILayoutConstraintAxisHorizontal];
    [_timestampLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh
                                       forAxis:UILayoutConstraintAxisHorizontal];
    
    //昵称
    _userNameLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = kTextColor404;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.right.equalTo(_timestampLabel.mas_left).offset(-10);
            make.top.equalTo(_headImageView);
            make.height.equalTo(@12);
        }];
        
        label;
    });
    
    [_timestampLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                                     forAxis:UILayoutConstraintAxisHorizontal];
    [_timestampLabel setContentHuggingPriority:UILayoutPriorityRequired
                                       forAxis:UILayoutConstraintAxisHorizontal];
    
    //评价内容
    _appraiseContentLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:14];
        label.preferredMaxLayoutWidth = SCREEN_WIDTH-55-15;
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userNameLabel);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(_userNameLabel.mas_bottom).offset(4);
        }];
        
        label;
    });
    
    //颜色款式
    _colorSizeLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = kTextColor404;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_appraiseContentLabel);
            make.top.equalTo(_appraiseContentLabel.mas_bottom).offset(4);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@12);
        }];
        
        label;
    });
    
    //图片
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _photoCollevtionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:collectionView];
        
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userNameLabel);
            make.right.equalTo(self.contentView);
            make.top.equalTo(_colorSizeLabel.mas_bottom).offset(10);
            make.height.equalTo(@55);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
        
        [collectionView registerNib:[UINib nibWithNibName:@"SingleImageCell" bundle:nil] forCellWithReuseIdentifier:kSingleImageCellIdentifier];
        
        collectionView;
    });
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(55, 55);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 7;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SingleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSingleImageCellIdentifier forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:_imageList[indexPath.row]];
    [cell.imageView packAspectFillModeSetImageWithURL:url placeholder:defaultImage03];
    
    return cell;
}


@end
