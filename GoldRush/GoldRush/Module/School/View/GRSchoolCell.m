//
//  GRSchoolCell.m
//  GoldRush
//
//  Created by Jack on 2017/2/23.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRSchoolCell.h"
#import "NSString+GRExtension.h"

@interface GRSchoolCell ()

@property (nonatomic, weak) UIImageView *detailImageView;
///
@property (nonatomic, weak) UILabel *titleLabel;
///
@property (nonatomic, weak) UILabel *descLabel;

@end

@implementation GRSchoolCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *image = [[UIImageView alloc] init];
        self.detailImageView = image;
        image.contentMode = UIViewContentModeScaleToFill;
        image.layer.masksToBounds = YES;
        [self.contentView addSubview:image];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-13);
        }];
        
        UILabel *title = [[UILabel alloc] init];
        [self.contentView addSubview:title];
        title.textColor = [UIColor colorWithHexString:@"#333333"];
        title.font = [UIFont systemFontOfSize:15];
        self.titleLabel = title;
        
        UILabel *desc = [[UILabel alloc] init];
        [self.contentView addSubview:desc];
        desc.textColor = [UIColor colorWithHexString:@"#666666"];
        desc.font = [UIFont systemFontOfSize:14];
        desc.numberOfLines = 0;
        self.descLabel = desc;
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image.mas_bottom).offset(10);
            make.leftMargin.mas_equalTo(image);
        }];
        
        [desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(title.mas_leftMargin);
            make.right.equalTo(self.contentView).offset(-13);
            make.top.equalTo(title.mas_bottom).offset(5);
        }];
    }
    return self;
}

- (void)setDataDict:(NSDictionary *)dataDict{
    _dataDict = dataDict;
    
    self.detailImageView.image = [UIImage imageNamed:dataDict[@"imageName"]];
    self.titleLabel.text = dataDict[@"title"];
    self.descLabel.text = dataDict[@"desc"];
}


+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    return [object[@"desc"] sizeWithLabelWidth:K_Screen_Width - 26 font:[UIFont systemFontOfSize:14]].size.height;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRSchoolCell";
    GRSchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRSchoolCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
