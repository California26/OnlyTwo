//
//  GRSystemCell.m
//  GoldRush
//
//  Created by Jack on 2016/12/29.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRSystemCell.h"

@implementation GRSystemCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
    
}

static NSString *cellID = @"system";
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    GRSystemCell *cell = [[GRSystemCell alloc] init];
    if (!cell) {
        cell = [[GRSystemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)setText:(NSString *)text{
    _text = text;
    self.textLabel.text = text;
}

@end
