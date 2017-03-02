//
//  GRChippedAnalystPlanCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/2.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRChippedAnalystPlanCell.h"

@implementation GRChippedAnalystPlanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *image = [[UIImageView alloc] init];
        image.backgroundColor = [UIColor redColor];
        if (iPhone5) {
            image.image = [UIImage imageNamed:@"Chipped_Second_Header_iPhone5"];
        }else if (iPhone6){
            image.image = [UIImage imageNamed:@"Chipped_Second_Header_iPhone6"];
        }else if (iPhone6P){
            image.image = [UIImage imageNamed:@"Chipped_Second_Header_iPhone6P"];
        }
        [self.contentView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.right.and.bottom.equalTo(self.contentView);
        }];
        image.contentMode = UIViewContentModeCenter;
    }
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"planCell";
    GRChippedAnalystPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRChippedAnalystPlanCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
