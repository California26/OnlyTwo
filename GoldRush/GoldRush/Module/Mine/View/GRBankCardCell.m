//
//  GRBankCardCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/20.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRBankCardCell.h"

@interface GRBankCardCell ()

@end

@implementation GRBankCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //
        self.imageView.image = [UIImage imageNamed:@"Mine_Card"];
        self.textLabel.text = @"建行";
        self.detailTextLabel.text = @"23424---34234";
        
        //选中按钮
        UIButton *selected = [UIButton buttonWithType:UIButtonTypeCustom];
        selected.frame = CGRectMake( 0, 0, 20, 20);
        selected.center = CGPointMake(K_Screen_Width - 30, self.contentView.centerY);
        [selected setImage:[UIImage imageNamed:@"Mine_Selected_Default"] forState:UIControlStateNormal];
        [selected setImage:[UIImage imageNamed:@"Mine_Selected_Selected"] forState:UIControlStateSelected];
        [selected addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:selected];
    }
    return self;
}

///支付方式后面的选择按钮
- (void)selectClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_bankCardCell:selectWhichBank:)]) {
        [self.delegate gr_bankCardCell:self selectWhichBank:btn];
    }

}

#pragma mark - setter and getter



+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRBankCardCell";
    GRBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRBankCardCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
