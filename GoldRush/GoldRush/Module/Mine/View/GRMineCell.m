//
//  GRMineCell.m
//  GoldRush
//
//  Created by Jack on 2016/12/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRMineCell.h"
#import "GRSettingItem.h"

@interface GRMineCell ()

@property (weak, nonatomic) UIImageView *dotImageView;

@end

@implementation GRMineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *image = [[UIImageView alloc] init];
        image.image = [UIImage imageNamed:@"Dot"];
        [self.contentView addSubview:image];
        self.dotImageView = image;
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right);
            make.width.and.height.equalTo(@20);
        }];
        image.hidden = YES;
        image.contentMode = UIViewContentModeCenter;
    }
    return self;
}


#pragma mark - setter and getter
- (void)setItem:(GRSettingItem *)item{
    _item = item;
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
}


- (void)setIsMessage:(BOOL)isMessage{
    _isMessage = isMessage;
    if (isMessage) {
        self.dotImageView.hidden = NO;
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRMineCell";
    GRMineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRMineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = GRColor(102, 102, 102);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

@end
