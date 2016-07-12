//
//  MinePageUserHeadCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/12.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MinePageUserHeadCell.h"
#import "GlobalColors.h"
@interface MinePageUserHeadCell() {
    
    __weak IBOutlet UIButton *mineHeadButton;
    __weak IBOutlet UILabel *mineNameLabel;
    __weak IBOutlet UIButton *collocationLogButton;
}
@end

@implementation MinePageUserHeadCell

- (void)awakeFromNib {
    // Initialization code
    collocationLogButton.layer.cornerRadius = 27/2.0;
    collocationLogButton.layer.borderColor = kCellLineColor.CGColor;
    collocationLogButton.layer.borderWidth = 0.5f;
}

@end
