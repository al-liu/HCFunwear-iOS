//
//  HCBuyQACell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/28.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCBuyQACell.h"
#import "GlobalImport.h"
#import "Masonry.h"

@interface HCBuyQACell ()
{
    UILabel *_qLabel;
    UILabel *_aLabel;
}
@end

@implementation HCBuyQACell

- (void)setData:(HCProductQAModel *)model {
    _qLabel.text = model.question;
    _aLabel.text = model.answer;
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
    //Q w-h-12 l-15 t-17
    UILabel *flagQLabel = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = kTextColor325;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        label.text = @"Q";
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.contentView).offset(17);
            make.width.height.equalTo(@12);
        }];
        
        label;
    });
    
    _qLabel = ({
        UILabel *label = [UILabel new];
        label.textColor = kTextColor325;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        label.preferredMaxLayoutWidth = SCREEN_WIDTH - 49;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(flagQLabel.mas_right).offset(7);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(flagQLabel).offset(-6);//...
        }];
        
        label;
    });
    
    UILabel *flagALabel = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = kFlagQABG;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        label.text = @"A";
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(flagQLabel);
            make.top.equalTo(_qLabel.mas_bottom).offset(12);
            make.width.height.equalTo(@12);
        }];
        
        label;
    });
    
    _aLabel = ({
        UILabel *label = [UILabel new];
        label.textColor = kTextColor404;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        label.preferredMaxLayoutWidth = SCREEN_WIDTH - 49;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(flagALabel.mas_right).offset(7);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(flagALabel).offset(-2);
            make.bottom.equalTo(self.contentView).offset(-17);
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

@end
