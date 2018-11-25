//
//  ZKNetLogCell.m
 
//
//  Created by ZK-2 on 2018/8/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZKNetLogCell.h"

@implementation ZKNetLogCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        UILabel *title = [UILabel new];
        title.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        title.font = [UIFont systemFontOfSize:16];
        title.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:title];
        
        UILabel *logLabel = [UILabel new];
        logLabel.numberOfLines = 0;
        logLabel.font = [UIFont systemFontOfSize:12];
        logLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:logLabel];

        //add Constrains
        NSDictionary *views  = NSDictionaryOfVariableBindings(title,logLabel);
        NSArray *HConstrains = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[title]-0-|" options:0 metrics:nil views:views];
        NSArray *logHConstrains = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[logLabel]-0-|" options:0 metrics:nil views:views];
        NSArray *VConstrains = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[title]-0-[logLabel]-0-|" options:0 metrics:nil views:views];
        [self.contentView addConstraints:HConstrains];
        [self.contentView addConstraints:logHConstrains];
        [self.contentView addConstraints:VConstrains];
        
        _logLabel = logLabel;
        _title = title;
    }
    return self;
}

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
