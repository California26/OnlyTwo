//
//  GRPropertyNOHoldPositionCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRPropertyNOHoldPositionCell.h"

@implementation GRPropertyNOHoldPositionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //未开单按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        [btn setTitle:@"您还未开单,火速来玩吧>>" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(openList:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)openList:(UIButton *)btn{
    
}

#pragma mark - private method
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRPropertyNOHoldPositionCell";
    GRPropertyNOHoldPositionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRPropertyNOHoldPositionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
