//
//  GRRechargeTitleCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/11.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRRechargeTitleCell.h"

@implementation GRRechargeTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        for (UIView *view in self.contentView.subviews) {
            [view removeFromSuperview];
        }
        NSArray *arytext = [NSArray arrayWithObjects:@"时间",@"类型",@"金额",@"范围", nil];
        for (int i = 0; i < arytext.count; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((K_Screen_Width/4)*i, 0, K_Screen_Width/4, 34)];
            label.text = arytext[i];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor colorWithHexString:@"#333333"];
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
        }
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRRechargeTitleCell";
    GRRechargeTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRRechargeTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
