//
//  GRADImageCell.m
//  GoldRush
//
//  Created by Jack on 2016/12/23.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRADImageCell.h"

@interface GRADImageCell ()

@property (weak, nonatomic) UIImageView *ADImageView;

@end

@implementation GRADImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *image = [[UIImageView alloc] init];
        image.image = [UIImage imageNamed:@"New_hand"];
        [self.contentView addSubview:image];
        self.ADImageView = image;
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.contentView).offset(5);
            make.bottom.equalTo(self.contentView).offset(-5);
            make.right.equalTo(self.contentView).offset(-13);
        }];
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.layer.masksToBounds = YES;
    }
    return self;
}


- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.ADImageView.image = [UIImage imageNamed:self.imageName];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"AD";
    GRADImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRADImageCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
