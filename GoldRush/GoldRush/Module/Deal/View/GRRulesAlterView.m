//
//  GRRulesAlterView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/2/16.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRRulesAlterView.h"
#define UILABEL_LINE_SPACE 3
@interface GRRulesAlterView ()

{
    NSString *stringText;
    CGFloat heightLabel;
}

@end

@implementation GRRulesAlterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        [self addSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame stringText:(NSString *)text height:(CGFloat)height
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        stringText = text;
        heightLabel   = height;
        [self addSubViews];
    }
    return self;
}


- (void)addSubViews
{
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width , 44)];
    labelTitle.text = @"持仓规则";
    labelTitle.font = [UIFont systemFontOfSize:17];
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.backgroundColor = [UIColor colorWithHexString:@"#00a0e9"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.frame.size.width - 60, 0, 40, 40);
    [button setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [labelTitle addSubview:button];
    [self addSubview:labelTitle];
    UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(7, CGRectGetMaxY(labelTitle.frame)+4, self.frame.size.width-14, heightLabel)];
    labelText.textColor = GRColor(102, 102, 102);
    labelText.font = [UIFont systemFontOfSize:12];
    labelText.numberOfLines = 0;
    labelText.backgroundColor = [UIColor whiteColor];
    labelText.text = stringText;
    [self setLabelSpace:labelText withValue:stringText withFont:[UIFont systemFontOfSize:12]];
    [self addSubview:labelText];
}

//给UILabel设置行间距和字间距
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.0f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

- (void)buttonAction:(UIButton *)sender
{
    [self.superview removeFromSuperview];
}


@end
