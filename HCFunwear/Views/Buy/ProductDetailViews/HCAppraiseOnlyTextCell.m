//
//  HCAppraiseOnlyTextCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/28.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCAppraiseOnlyTextCell.h"
#import "Masonry.h"
#import "GlobalImport.h"

@interface HCAppraiseOnlyTextCell ()
{
    UIImageView *_headImageView;
    UILabel *_userNameLabel;
    UILabel *_timestampLabel;
    UILabel *_appraiseContentLabel;
    UILabel *_colorSizeLabel;
    UILabel *_shopReplyLabel;
    
    UIView *_line;
    
    HCCommentListSubsModel *_sub;
}
@end

@implementation HCAppraiseOnlyTextCell

- (void)setData:(HCCommentListModel *)model {
    _userNameLabel.text = model.nick_name;
    _timestampLabel.text = model.create_time;
    _appraiseContentLabel.text = model.info;
    _colorSizeLabel.text = [NSString stringWithFormat:@"颜色：%@ 尺寸：%@",model.product_color,model.product_size];
    _sub = model.subs.firstObject;//只做了一个回复
    if (_sub.info && ![_sub.info isEqualToString:@""]) {
        _line.hidden = NO;
        _shopReplyLabel.text = [NSString stringWithFormat:@"[有范回复]:%@",_sub.info];
    }
    else {
        _line.hidden = YES;
    }
}

- (void)updateConstraints {
    CGFloat offset = 0;
    if (_sub.info && ![_sub.info isEqualToString:@""]) {
        offset = 10;
    }

    [_shopReplyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_appraiseContentLabel);
        make.top.equalTo(_line.mas_bottom).offset(offset);
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.contentView).offset(-offset);
    }];

    
    [super updateConstraints];
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
    
    //line
    _line = ({
        UIView *view = [UIView new];
        view.backgroundColor = kCellLineColor;
        [self.contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@.5f);
            make.left.equalTo(_colorSizeLabel);
            make.right.equalTo(self.contentView);
            make.top.equalTo(_colorSizeLabel.mas_bottom).offset(10);
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
            make.top.equalTo(_line.mas_bottom).offset(10);
            make.right.equalTo(self.contentView).offset(-15);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
        
        label;
    });

    MASAttachKeys(_headImageView,_userNameLabel,_timestampLabel,_appraiseContentLabel,_colorSizeLabel,_line,_shopReplyLabel);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
