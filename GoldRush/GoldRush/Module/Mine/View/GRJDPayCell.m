//
//  GRJDPayCell.m
//  GoldRush
//
//  Created by Jack on 2017/2/17.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRJDPayCell.h"

@interface GRJDPayCell ()<UITextFieldDelegate>

///
@property (nonatomic, weak) UILabel *titleLabel;
///
@property (nonatomic, weak) UITextField *textField;

@end


@implementation GRJDPayCell

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
    if ([title isEqualToString:@"银行卡号"] || [title isEqualToString:@"身份证号码"] || [title isEqualToString:@"手机号码"]) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_JDPayCell:didEndEditing:)]) {
        [self.delegate gr_JDPayCell:self didEndEditing:textField];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_JDPayCell:shouldBeginEditing:)]) {
        [self.delegate gr_JDPayCell:self shouldBeginEditing:textField];
    }
    return YES;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRJDPayCell";
    GRJDPayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRJDPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
