//
//  ZKNetLogCell.m
 
//
//  Created by ZK-2 on 2018/8/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZKNetLogCell.h"

@implementation ZKNetLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
