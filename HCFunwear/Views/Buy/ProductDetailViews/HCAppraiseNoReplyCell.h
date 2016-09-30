//
//  HCAppraiseNoReplyCell.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/30.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCAppraiseCell.h"
#import "HCAppraiseCellProtocol.h"

@interface HCAppraiseNoReplyCell : UITableViewCell<HCAppraiseCellProtocol>

- (void)setData:(HCCommentListModel *)model;

@end
