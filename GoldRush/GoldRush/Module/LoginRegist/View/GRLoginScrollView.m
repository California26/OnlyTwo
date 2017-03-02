//
//  GRLoginScrollView.m
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/20.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRLoginScrollView.h"
#import "GRCountDownBtn.h"              ///获取验证码按钮

#define kLineHeight 15
#define kLineMag    45
#define kLineX      15


@interface GRLoginScrollView ()<UITextFieldDelegate>{
    GRCountDownBtn *getBtn;
    UIButton *rightBtn;
}
@property (nonatomic,strong) NSArray *aryPoint;

@property (nonatomic, weak) UITextField *phoneTextField;        ///手机号
@property (nonatomic, weak) UIButton *affirmBtn;                ///确定按钮

@end

@implementation GRLoginScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.scrollEnabled = NO;
        self.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        self.contentSize = CGSizeMake(K_Screen_Width, K_Screen_Height + 100);
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self addsubViews];
    }
    return self;
}


- (void)addsubViews{
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(K_Screen_Width/2-50, 64+20, 100, 100)];
    iconView.backgroundColor = [UIColor lightGrayColor];
    iconView.layer.cornerRadius = iconView.frame.size.width/2;
    iconView.image = [UIImage imageNamed:@"Gold_Rush_Logo"];
    iconView.layer.masksToBounds = YES;
    [self addSubview:iconView];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconView.frame)+15, K_Screen_Width, 20)];
    labelTitle.text = @"全民淘金";
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.font = [UIFont systemFontOfSize:18];
    labelTitle.textColor = [UIColor colorWithHexString:@"#333333"];
    [self addSubview:labelTitle];
    
    UITextField *iphoneField = [[UITextField alloc] initWithFrame:CGRectMake(kLineX, CGRectGetMaxY(labelTitle.frame)+15, K_Screen_Width-kLineX*2, 45)];
    self.phoneTextField = iphoneField;
    iphoneField.placeholder = @"请输入手机号";
    iphoneField.font = [UIFont systemFontOfSize:15];
    iphoneField.textColor = [UIColor colorWithHexString:@"#999999"];
    iphoneField.keyboardType = UIKeyboardTypeNumberPad;
    iphoneField.delegate = self;
    iphoneField.tag = 1000;
    iphoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    iphoneField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:iphoneField];
    
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(kLineX, CGRectGetMaxY(iphoneField.frame)+10, K_Screen_Width-100-15*3, 45)];
    passwordField.placeholder = @"短信验证码";
    passwordField.font = iphoneField.font;
    passwordField.textColor = iphoneField.textColor;
    passwordField.delegate = self;
    passwordField.tag = 1001;
    passwordField.keyboardType = UIKeyboardTypePhonePad;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    passwordField.returnKeyType = UIReturnKeyDone;
    [self addSubview:passwordField];
    
    getBtn = [GRCountDownBtn buttonWithType:UIButtonTypeCustom];
    [getBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    getBtn.layer.cornerRadius = 5.0f;
    getBtn.layer.masksToBounds = YES;
    getBtn.frame = CGRectMake(K_Screen_Width - kLineX - 100, CGRectGetMinY(passwordField.frame), 100, 45);
    [getBtn addTarget:self action:@selector(getBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    getBtn.backgroundColor = GRColor(224, 224, 224);
    [self addSubview:getBtn];
    
    UIButton *forBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forBtn setTitle:@"确定" forState:UIControlStateNormal];
    [forBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    forBtn.backgroundColor = mainColor;
    forBtn.frame = CGRectMake(kLineX, CGRectGetMaxY(getBtn.frame)+35,K_Screen_Width-30, 44);
    [forBtn addTarget:self action:@selector(forBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    forBtn.layer.cornerRadius = 5.0f;
    forBtn.layer.masksToBounds = YES;
    [self addSubview:forBtn];
    self.affirmBtn = forBtn;
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(K_Screen_Width/2-110-30, CGRectGetMaxY(forBtn.frame)+13,20, 20);
    [rightBtn addTarget:self action:@selector(regBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"Reg_Round_Right"];
    CGFloat top = 2; // 顶端盖高度
    CGFloat bottom = 2; // 底端盖高度
    CGFloat left = 2; // 左端盖宽度
    CGFloat right = 2; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];

    [rightBtn setImage:image forState:UIControlStateNormal];
    rightBtn.showsTouchWhenHighlighted = YES;
    [self addSubview:rightBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(K_Screen_Width/2-90-30, CGRectGetMinY(rightBtn.frame), 90, 20)];
    label.text = @"我已同意并阅读";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    [self addSubview:label];
    
    UIButton *buttonProtocol = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonProtocol setTitle:@"《全民淘金贵金属服务协议》" forState:UIControlStateNormal];
    [buttonProtocol setTitleColor:[UIColor colorWithHexString:@"#3d7aeb"] forState:UIControlStateNormal];
    buttonProtocol.titleLabel.font = [UIFont systemFontOfSize:12];
    [buttonProtocol addTarget:self action:@selector(buttonProtocolAction:) forControlEvents:UIControlEventTouchUpInside];
    buttonProtocol.frame = CGRectMake(K_Screen_Width/2-30, CGRectGetMinY(label.frame), 160, 20);
    [self addSubview:buttonProtocol];
}

- (void)regBtnAction:(UIButton *)sender{
    if (sender.showsTouchWhenHighlighted) {
        [sender setImage:[UIImage imageNamed:@"Reg_Round"] forState:UIControlStateNormal];
        sender.showsTouchWhenHighlighted = NO;
    }else{
        sender.showsTouchWhenHighlighted = YES;
        [sender setImage:[UIImage imageNamed:@"Reg_Round_Right"] forState:UIControlStateNormal];
    }
    [self.loginDelegate loginAgreeAction:sender];
}

- (void)forBtnAction:(UIButton *)sender{
    if (rightBtn.showsTouchWhenHighlighted) {
        [self.loginDelegate loginSureActionWith:sender];
    }else{
        [SVProgressHUD showErrorWithStatus:@"你还没同意呢!"];
    }
}

//获取验证码点击
- (void)getBtnAction:(UIButton *)sender{
    if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(loginGetCodeAction:)]) {
        [self.loginDelegate loginGetCodeAction:sender];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(loginEndChangeWithTextField:)]) {
        [self.loginDelegate loginEndChangeWithTextField:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self setContentOffset:CGPointMake(0, 0)];
    if (textField.tag == 1001) {
        WS(weakself)
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (iPhone5) {
                CGPoint point = CGPointMake(0, 0);
                weakself.contentOffset = point;
            }else{
                
            }
        } completion:^(BOOL finished) {
            weakself.scrollEnabled = NO;
        }];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length || ![string isEqualToString:@""]) {
        if (textField.text.length == 1 && [string isEqualToString:@""]) {   //长度为1且为空时
            if (textField == self.phoneTextField) {
                getBtn.enabled = NO;
            }else{
                getBtn.enabled = YES;
            }
        }else{
            if (self.isTime) {  //正在获取验证码
                getBtn.enabled = NO;
            }else{
                getBtn.enabled = YES;
            }
        }
    }
    //改变获取验证码按钮的颜色
    [self changeCaptchaButtonColor];
    return YES;
}

#pragma mark - 改变注册按钮的颜色
//改变获取验证码按钮的颜色
- (void)changeCaptchaButtonColor{
    if (getBtn.enabled) {
        getBtn.backgroundColor = [UIColor colorWithHexString:@"#00a0e9"];
    } else {
        getBtn.backgroundColor = GRColor(224, 224, 224);
    }
}

#pragma mark 协议
- (void)buttonProtocolAction:(UIButton *)sender{
    [self.loginDelegate loginWithProtocol];
}

@end
