//
//  GRContactCell.m
//  GoldRush
//
//  Created by Jack on 2017/2/20.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRContactCell.h"

@implementation GRContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRContactCell";
    GRContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRContactCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    self.textLabel.text = dict[@"title"];
    self.detailTextLabel.text = dict[@"desc"];
}

@end
