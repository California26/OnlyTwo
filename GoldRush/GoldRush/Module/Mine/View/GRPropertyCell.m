//
//  GRPropertyCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRPropertyCell.h"

@interface GRPropertyCell ()

@property (nonatomic, weak) UILabel *moneyLabel;
@property (nonatomic, weak) UILabel *thicketLabel;

@end

@implementation GRPropertyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    
    UIButton *totalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:totalBtn];
    [totalBtn setTitle:@"总资产" forState:UIControlStateNormal];
    [totalBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    totalBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    totalBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 15, 0);
    totalBtn.imageEdgeInsets = UIEdgeInsetsMake(-5, -10, 10, 5);
    [totalBtn setImage:[UIImage imageNamed:@"Mine_Total_Property"] forState:UIControlStateNormal];
    [totalBtn addTarget:self action:@selector(totalClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *discountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:discountBtn];
    [discountBtn setTitle:@"抵金券" forState:UIControlStateNormal];
    [discountBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    discountBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    discountBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 15, 0);
    discountBtn.imageEdgeInsets = UIEdgeInsetsMake(-5, -10, 10, 5);
    [discountBtn setImage:[UIImage imageNamed:@"Ticket"] forState:UIControlStateNormal];
    [discountBtn addTarget:self action:@selector(discountClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [totalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(self);
        make.right.equalTo(discountBtn.mas_left);
        make.width.equalTo(discountBtn.mas_width);
    }];
    
    [discountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.bottom.equalTo(self);
        make.left.equalTo(totalBtn.mas_right);
        make.width.equalTo(totalBtn.mas_width);
    }];
    
    UILabel *money = [[UILabel alloc] init];
    [totalBtn addSubview:money];
    money.textColor = [UIColor colorWithHexString:@"#666666"];
    money.font = [UIFont systemFontOfSize:15];
    money.text = @"0.00元";
    self.moneyLabel = money;
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(totalBtn.mas_centerX);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    UILabel *pieces = [[UILabel alloc] init];
    [discountBtn addSubview:pieces];
    pieces.text = @"0张";
    self.thicketLabel = pieces;
    pieces.textColor = [UIColor colorWithHexString:@"#666666"];
    pieces.font = [UIFont systemFontOfSize:15];
    [pieces mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(discountBtn.mas_centerX);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#666666"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@1);
        make.height.equalTo(@25);
    }];
}

- (void)totalClick:(UIButton *) btn{
    if (self.totalPropertyBlock) {
        self.totalPropertyBlock();
    }
}

- (void)discountClick:(UIButton *)btn{
    if (self.discountBlock) {
        self.discountBlock();
    }
}

#pragma mark - setter and getter
- (void)setMoney:(NSString *)money{
    _money = money;
    if (money) {
        self.moneyLabel.text = [NSString stringWithFormat:@"%@元",money];
    }
}

- (void)setThicket:(NSString *)thicket{
    _thicket = thicket;
    if (thicket) {
        self.thicketLabel.text = [NSString stringWithFormat:@"%@张",thicket];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRPropertyCell";
    GRPropertyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRPropertyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
