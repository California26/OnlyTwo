//
//  GRHDWithDrawCell.m
//  GoldRush
//
//  Created by Jack on 2017/2/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRHDWithDrawCell.h"

@interface GRHDWithDrawCell ()<UITextFieldDelegate>

///
@property (nonatomic, weak) UILabel *titleLabel;
///
@property (nonatomic, weak) UITextField *textField;

@end

@implementation GRHDWithDrawCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *text = [[UILabel alloc] init];
        [self.contentView addSubview:text];
        text.font = [UIFont systemFontOfSize:15];
        self.titleLabel = text;
        text.textColor = [UIColor colorWithHexString:@"#333333"];
        
        UITextField *field = [[UITextField alloc] init];
        [self.contentView addSubview:field];
        field.delegate = self;
        self.textField = field;
        
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
        }];
        
        [field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(100);
            make.centerY.equalTo(text.mas_centerY);
            make.width.equalTo(@(K_Screen_Width - 113));
            make.height.equalTo(@40);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
    if ([title isEqualToString:@"银行卡号"]) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_HDWithDrawCell:didEndEditing:)]) {
        [self.delegate gr_HDWithDrawCell:self didEndEditing:textField];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_HDWithDrawCell:shouldBeginEditing:)]) {
        [self.delegate gr_HDWithDrawCell:self shouldBeginEditing:textField];
    }
    return YES;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRHDWithDrawCell";
    GRHDWithDrawCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRHDWithDrawCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
