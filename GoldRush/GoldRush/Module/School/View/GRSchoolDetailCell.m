//
//  GRSchoolDetailCell.m
//  GoldRush
//
//  Created by Jack on 2017/2/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRSchoolDetailCell.h"

@interface GRSchoolDetailCell ()

@property (nonatomic, weak) UIImageView *detailImageView;

@end

@implementation GRSchoolDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *image = [[UIImageView alloc] init];
        self.detailImageView = image;
        image.contentMode = UIViewContentModeCenter;
        image.layer.masksToBounds = YES;
        [self.contentView addSubview:image];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.contentView).offset(5);
            make.right.equalTo(self.contentView).offset(-13);
            make.bottom.equalTo(self.contentView).offset(-5);
        }];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.detailImageView.frame = CGRectMake(13, 0, K_Screen_Width - 26, self.bounds.size.height);
}

- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    
    self.detailImageView.image = [UIImage imageNamed:imageName];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRSchoolDetailCell";
    GRSchoolDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRSchoolDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
