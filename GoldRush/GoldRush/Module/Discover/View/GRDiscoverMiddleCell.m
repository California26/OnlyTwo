//
//  GRDiscoverMiddleCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/12.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRDiscoverMiddleCell.h"
#import "GRDiscover.h"              ///数据模型

@implementation GRDiscoverMiddleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
    }
    return self;
}

- (void)setModel:(GRDiscover *)model{
    _model = model;
    
    self.imageView.image = [UIImage imageNamed:model.iconUrl];
    self.textLabel.text = model.title;
    self.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    
    self.detailTextLabel.text = model.desc;
    self.detailTextLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.detailTextLabel.font = [UIFont systemFontOfSize:12];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRDiscoverMiddleCell";
    GRDiscoverMiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRDiscoverMiddleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
