//
//  GRWithDrawView.m
//  GoldRush
//
//  Created by Jack on 2017/1/19.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRWithDrawView.h"
#import "GRJudgeBnakType.h"         ///判断银行卡类型

@interface GRWithDrawView ()<UITextFieldDelegate>

@property (nonatomic, weak) UITextField *bankCardFiled;         ///银行卡
@property (nonatomic, weak) UITextField *bankTypeFiled;         ///银行卡类型
@property (nonatomic, weak) UITextField *openAccountProvince;   ///开户省份
@property (nonatomic, weak) UITextField *openAccountCity;       ///开户城市

@end

@implementation GRWithDrawView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *tip = [[UILabel alloc] init];
        [self addSubview:tip];
        tip.text = @"   您需要使用现金交易一次后才可提现";
        tip.textColor = [UIColor colorWithHexString:@"#666666"];
        tip.backgroundColor = defaultBackGroundColor;
        tip.font = [UIFont systemFontOfSize:15];
        
        //添加银行卡号输入框
        UITextField *cardNum = [[UITextField alloc] init];
        [self addSubview:cardNum];
        cardNum.borderStyle = UITextBorderStyleRoundedRect;
        cardNum.placeholder = @"请输入银行卡号";
        self.bankCardFiled = cardNum;
        cardNum.keyboardType = UIKeyboardTypeNumberPad;
        cardNum.delegate = self;
        cardNum.tag = 2017 + 1;
        
        UILabel *bankNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [self addSubview:bankNum];
        bankNum.textColor = [UIColor colorWithHexString:@"#333333"];
        bankNum.font = [UIFont systemFontOfSize:15];
        bankNum.textAlignment = NSTextAlignmentCenter;
        bankNum.text = @"银行卡号";
        cardNum.leftView = bankNum;
        cardNum.leftViewMode = UITextFieldViewModeAlways;
        
        //添加银行卡类型输入框
        UITextField *cardType = [[UITextField alloc] init];
        [self addSubview:cardType];
        cardType.borderStyle = UITextBorderStyleRoundedRect;
        cardType.placeholder = @"请输入银行类型";
        self.bankTypeFiled = cardType;
        cardType.delegate = self;
        cardType.tag = 2017 + 2;
        cardType.enabled = NO;
        
        UILabel *bankType = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [self addSubview:bankType];
        bankType.textColor = [UIColor colorWithHexString:@"#333333"];
        bankType.font = [UIFont systemFontOfSize:15];
        bankType.textAlignment = NSTextAlignmentCenter;
        bankType.text = @"银行类型";
        cardType.leftView = bankType;
        cardType.leftViewMode = UITextFieldViewModeAlways;
        
        //添加姓名输入框
        UITextField *name = [[UITextField alloc] init];
        [self addSubview:name];
        name.borderStyle = UITextBorderStyleRoundedRect;
        name.placeholder = @"请输入持卡人姓名";
        name.delegate = self;
        name.tag = 2017 + 3;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [self addSubview:nameLabel];
        nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.text = @"姓名";
        name.leftView = nameLabel;
        name.leftViewMode = UITextFieldViewModeAlways;
        
        //添加开户省份输入框
        UITextField *province = [[UITextField alloc] init];
        [self addSubview:province];
        province.delegate = self;
        province.borderStyle = UITextBorderStyleRoundedRect;
        province.placeholder = @"请输入开户省份";
        self.openAccountProvince = province;
        province.tag = 2017 + 4;
        
        UILabel *provinceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [self addSubview:provinceLabel];
        provinceLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        provinceLabel.font = [UIFont systemFontOfSize:15];
        provinceLabel.textAlignment = NSTextAlignmentCenter;
        provinceLabel.text = @"开户省份";
        province.leftView = provinceLabel;
        province.leftViewMode = UITextFieldViewModeAlways;
        
        //添加开户城市输入框
        UITextField *city = [[UITextField alloc] init];
        [self addSubview:city];
        city.borderStyle = UITextBorderStyleRoundedRect;
        city.placeholder = @"请输入开户城市";
        city.delegate = self;
        self.openAccountCity = city;
        city.tag = 2017 + 5;
        
        UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [self addSubview:cityLabel];
        cityLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cityLabel.font = [UIFont systemFontOfSize:15];
        cityLabel.textAlignment = NSTextAlignmentCenter;
        cityLabel.text = @"开户城市";
        city.leftView = cityLabel;
        city.leftViewMode = UITextFieldViewModeAlways;
        
        //添加开户支行输入框
        UITextField *subBranch = [[UITextField alloc] init];
        [self addSubview:subBranch];
        subBranch.borderStyle = UITextBorderStyleRoundedRect;
        subBranch.placeholder = @"请输入开户支行";
        subBranch.delegate = self;
        subBranch.tag = 2017 + 6;
        
        UILabel *subBranchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [self addSubview:subBranchLabel];
        subBranchLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        subBranchLabel.font = [UIFont systemFontOfSize:15];
        subBranchLabel.textAlignment = NSTextAlignmentCenter;
        subBranchLabel.text = @"开户支行";
        subBranch.leftView = subBranchLabel;
        subBranch.leftViewMode = UITextFieldViewModeAlways;
        
        //下一步按钮
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        nextBtn.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
        nextBtn.enabled = NO;
        nextBtn.layer.masksToBounds = YES;
        nextBtn.layer.cornerRadius = 10;
        [nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextBtn];
        
        //约束
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(5);
            make.height.equalTo(@30);
        }];
        
        [cardNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(tip.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@44);
        }];
        
        [cardType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(cardNum.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@44);
        }];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(cardType.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@44);
        }];
        
        [province mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(name.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@44);
        }];
        
        [city mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(province.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@44);
        }];
        
        [subBranch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(city.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(@44);
        }];
        
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(42);
            make.top.equalTo(subBranch.mas_bottom).offset(20);
            make.right.equalTo(self).offset(-42);
            make.height.equalTo(@44);
        }];
    }
    return self;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == self.bankCardFiled) {
        self.bankTypeFiled.text = [GRJudgeBnakType returnBankName:self.bankCardFiled.text];
    }
    
    if ([self.delegate respondsToSelector:@selector(gr_withDrawView:didEndEditing:)]) {
        [self.delegate gr_withDrawView:self didEndEditing:textField];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_withDrawView:didBeginEditing:)]) {
        [self.delegate gr_withDrawView:self didBeginEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.bankCardFiled) {
        NSString *text = textField.text;
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        // 限制长度
        if (newString.length >= 24) {
            return NO;
        }
        textField.text = newString;
        return NO;
    }else{
        return YES;
    }
}

///点击下一步按钮
- (void)nextClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(gr_withDrawView:didClickNextButton:)]) {
        [self.delegate gr_withDrawView:self didClickNextButton:btn];
    }
}

@end
