//
//  GRIntroduceTotalProfitCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRIntroduceTotalProfitCell.h"

@interface GRIntroduceTotalProfitCell ()

@property (nonatomic, weak) UILabel *totalProfitLabel;      ///总共盈利

@end

@implementation GRIntroduceTotalProfitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //总共盈利
        UILabel *total = [[UILabel alloc] init];
        [self.contentView addSubview:total];
        total.textAlignment = NSTextAlignmentCenter;
        total.textColor = [UIColor colorWithHexString:@"#333333"];
        total.font = [UIFont systemFontOfSize:14];
        self.totalProfitLabel = total;
        
        //布局
        [total mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

#pragma mark - setter and getter
- (void)setTotalProfit:(NSString *)totalProfit{
    _totalProfit = totalProfit;
    
    NSRange range = [totalProfit stringSubWithString:@"了" andString:@"元"];
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#d43c33"]};
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:totalProfit];
    [attribut addAttributes:dict range:range];
    self.totalProfitLabel.attributedText = attribut;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRIntroduceTotalProfitCell";
    GRIntroduceTotalProfitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRIntroduceTotalProfitCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
