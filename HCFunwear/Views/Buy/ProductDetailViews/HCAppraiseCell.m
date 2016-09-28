//
//  HCAppraiseCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/27.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCAppraiseCell.h"
#import "Masonry.h"
#import "GlobalColors.h"
#import "SingleImageCell.h"
#import "GlobalConstant.h"
#import "UIColor+YYAdd.h"

@interface HCAppraiseCell () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIImageView *_headImageView;
    UILabel *_userNameLabel;
    UILabel *_timestampLabel;
    UILabel *_appraiseContentLabel;
    UILabel *_colorSizeLabel;
    UICollectionView *_photoCollevtionView;
    UILabel *_shopReplyLabel;
}
@end

@implementation HCAppraiseCell

- (void)setData {
    _userNameLabel.text = @"海纳百川";
    _timestampLabel.text = @"1900年前";
    _appraiseContentLabel.text = @"山东发送到发送到发送发送的方式出现在大风持续持续线程的虽然文件上的风景阿斯顿发的是风刀霜剑的司法鉴定撒风";
    _colorSizeLabel.text = @"颜色：宝蓝深蓝 尺寸：170/92A";
    _shopReplyLabel.text = @"[有范回复]：亲您好，大幅度撒风啊风多少啊多少发多少发觉可视电话风景的撒风宁可接受撒地方撒的大撒风。：亲您好，大幅度撒风啊风多少啊多少发多少发觉可视电话风景的撒风宁可接受撒地方撒的大撒风。";
    
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
        label.text = @"109天前";
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
        label.text = @"言言言";
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
        label.text = @"山东发送到发送到发送发送的方式出现在大风持续持续线程的虽然文件上的风景阿斯顿发的是风刀霜剑的司法鉴定撒风";
        label.preferredMaxLayoutWidth = SCREEN_WIDTH-55-73;
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userNameLabel);
            make.right.equalTo(self.contentView).offset(-73);
            make.top.equalTo(_userNameLabel.mas_bottom).offset(4);
        }];
        
        label;
    });
    
    //颜色款式
    _colorSizeLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = kTextColor404;
        label.text = @"颜色：宝蓝深蓝 尺寸：170/92A";
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
        }];
        
        [collectionView registerNib:[UINib nibWithNibName:@"SingleImageCell" bundle:nil] forCellWithReuseIdentifier:kSingleImageCellIdentifier];
        
        collectionView;
    });

    //line
    UIView *line = ({
        UIView *view = [UIView new];
        view.backgroundColor = kCellLineColor;
        [self.contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@.5f);
            make.left.equalTo(_photoCollevtionView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(_photoCollevtionView.mas_bottom).offset(10);
        }];
        
        view;
    });
    
    //商家回复
    _shopReplyLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:12];
//        label.textColor = [UIColor colorWithHexString:@"#FFFFC407"];
//        label.text = @"ds";
        label.preferredMaxLayoutWidth = SCREEN_WIDTH-55-15;
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        
//        label.backgroundColor = [UIColor colorWithRed:0.486 green:0.616 blue:0.835 alpha:1.000];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_appraiseContentLabel);
            make.top.equalTo(line.mas_bottom).offset(10);
            make.right.equalTo(self.contentView).offset(-15);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
        
        label;
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
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SingleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSingleImageCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:0.086 green:0.400 blue:0.973 alpha:1.000];
    
    return cell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

@end
