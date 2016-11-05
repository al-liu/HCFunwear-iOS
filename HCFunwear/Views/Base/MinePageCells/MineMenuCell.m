//
//  MineMenuCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/12.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MineMenuCell.h"
@interface MineMenuCell() {
    
    __weak IBOutlet UIImageView *iconImageView;
    __weak IBOutlet UILabel *iconTitleLabel;
}
@end

@implementation MineMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMineMenuModel:(MineMenuModel *)mineMenuModel {
    _mineMenuModel = mineMenuModel;
    
    iconImageView.image = [UIImage imageNamed:_mineMenuModel.iconImageString];
    iconTitleLabel.text = _mineMenuModel.iconTitleString;
}
@end
