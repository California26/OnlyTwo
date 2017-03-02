//
//  GRUserProfitCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/10.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRUserProfitCell.h"

@interface GRUserProfitCell ()

@property (nonatomic, weak) UILabel *nameLabel;         ///用户名字
@property (nonatomic, weak) UILabel *profitLabel;       ///盈利金额

@end

@implementation GRUserProfitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //名字
        UILabel *name = [[UILabel alloc] init];
        [self.contentView addSubview:name];
        name.textColor = [UIColor colorWithHexString:@"#3d7aeb"];
        name.font = [UIFont systemFontOfSize:14];
        name.text = @"全民小道";
        
        //盈利金额
        UILabel *profit = [[UILabel alloc] init];
        [self.contentView addSubview:profit];
        profit.font = [UIFont systemFontOfSize:14];
        profit.textColor = [UIColor colorWithHexString:@"#666666"];
        NSString *str = @"12月24日参与合买赚了360元";
        NSRange range = [str stringSubWithString:@"了" andString:@"元"];
        NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#d43c33"]};
        NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:str];
        [attribut addAttributes:dict range:range];
        profit.attributedText = attribut;
        
        //布局
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.bottom.equalTo(self.contentView);
        }];
        
        [profit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-25);
            make.top.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRUserProfitCell";
    GRUserProfitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRUserProfitCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



@end
