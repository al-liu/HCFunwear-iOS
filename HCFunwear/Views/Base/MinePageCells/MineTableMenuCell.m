//
//  MineTableMenuCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/12.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MineTableMenuCell.h"
@interface MineTableMenuCell() {
    
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *subTitleLabel;
    __weak IBOutlet UIView *awakePointView;
    __weak IBOutlet NSLayoutConstraint *lineLeadingConstrint;
}
@end

@implementation MineTableMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    awakePointView.layer.cornerRadius = 7/2.0;
    awakePointView.layer.masksToBounds = YES;
}

- (void)setLineLeadingConstant:(CGFloat)lineLeadingConstant {
    _lineLeadingConstant = lineLeadingConstant;
    lineLeadingConstrint.constant = _lineLeadingConstant;
}

- (void)setIsShowAwakePoint:(BOOL)isShowAwakePoint {
    _isShowAwakePoint = isShowAwakePoint;
    awakePointView.hidden = !_isShowAwakePoint;
}

- (void)setIsShowSubTitle:(BOOL)isShowSubTitle {
    _isShowSubTitle = isShowSubTitle;
    subTitleLabel.hidden = !_isShowSubTitle;
}

- (void)setTableMenuModel:(MineTableMenuModel *)tableMenuModel {
    _tableMenuModel = tableMenuModel;
    titleLabel.text = _tableMenuModel.title;
    subTitleLabel.text = _tableMenuModel.subTitle;
    awakePointView.hidden = !_tableMenuModel.showPoint;
}

@end
