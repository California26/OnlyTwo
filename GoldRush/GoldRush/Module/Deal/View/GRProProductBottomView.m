//
//  GRProProductBottomView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/18.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRProProductBottomView.h"
#import "GRRulesAlterView.h"
#import "GRBlurEffect.h"

#define UILABEL_LINE_SPACE 3
#define HEIGHT [ [ UIScreen mainScreen ] bounds ].size.height
@interface GRProProductBottomView ()
@property (nonatomic,strong) UILabel  *productNamelabel;
@property (nonatomic,strong) UILabel  *positionRule;
@property (nonatomic,strong) UIButton *buttonDetail;
@property (nonatomic,strong) GRRulesAlterView *alterView;
@property(nonatomic, strong) GRBlurEffect *blurEffect;      ///模糊背景

@end

@implementation GRProProductBottomView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = defaultBackGroundColor;
        [self addSubview:self.productNamelabel];
        [self addSubview:self.positionRule];
        [self addSubview:self.buttonDetail];
    }
    return self;
}
- (UILabel *)productNamelabel
{
    if (!_productNamelabel) {
        _productNamelabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, 20)];
        _productNamelabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _productNamelabel.font = [UIFont systemFontOfSize:11];
        _productNamelabel.text = @"恒大银  最新持仓数";
    }
    return _productNamelabel;
}

- (UILabel *)positionRule
{
    if (!_positionRule) {
        _positionRule = [[UILabel alloc] initWithFrame:CGRectMake(K_Screen_Width-50-100, 0, 100, 20)];
        _positionRule.textColor = _productNamelabel.textColor;
        _positionRule.text = @"持仓规则";
        _positionRule.font = [UIFont systemFontOfSize:11];
        _positionRule.textAlignment = NSTextAlignmentRight;
        _positionRule.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction)];
        [_positionRule addGestureRecognizer:tap];
    }
    return _positionRule;
}


- (UIButton *)buttonDetail
{
    if (!_buttonDetail) {
        _buttonDetail = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonDetail setImage:[UIImage imageNamed:@"detail"] forState:UIControlStateNormal];
        _buttonDetail.frame = CGRectMake(K_Screen_Width - 35,0, 20, 20);
        [_buttonDetail addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        _buttonDetail.showsTouchWhenHighlighted = YES;
    }
    return _buttonDetail;
}

//- (GRRulesAlterView *)alterView
//{
////    if (!_alterView) {
////        _alterView = [[GRRulesAlterView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
////    }
//}



//计算UILabel的高度(带有行间距的情况)
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.0f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

- (void)buttonAction
{
    self.blurEffect = [[GRBlurEffect alloc] init];
    if (_buttonDetail.showsTouchWhenHighlighted) {
        _buttonDetail.showsTouchWhenHighlighted = NO;
        if ([self.productName isEqualToString:HD_ProductName]) {
            NSString *string1 = @"  交易手续费为0.8元/手，6元/手，24元/手，平仓不收取手续费，持仓上限10手，持仓单不过夜，如持仓订单在结算时间前未平仓，将会被系统强制转让。";
            CGFloat textHeight = [self getSpaceLabelHeight:string1 withFont:[UIFont systemFontOfSize:12] withWidth:K_Screen_Width-26-14];
            self.alterView = [[GRRulesAlterView alloc] initWithFrame:CGRectMake(13, -206, K_Screen_Width - 26, 44+textHeight+8) stringText:string1 height:textHeight];
            
        }else{
            NSString *string2 = @"  10元/手 持仓上限20手 200元/手  持仓上限60手  2000元/手持仓上限40手  2000元/手交割带纳金15元/天  10元/手  200元/手 不支持持仓过夜，故不产生交割带纳金费用。若持仓单在每日结算点前未平仓，系统会以当天收盘价对订单进行结算。200元/手可持仓过夜，持仓单于每天结算点根据手数收取交割带纳金，此外，若2000元/手的商品持仓单于当周最后一个交易日结算点前未平仓，系统会以当天收盘价对订单进行结算.";
            CGFloat textHeight = [self getSpaceLabelHeight:string2 withFont:[UIFont systemFontOfSize:12] withWidth:K_Screen_Width-26-14];
            self.alterView = [[GRRulesAlterView alloc] initWithFrame:CGRectMake(13, -206, K_Screen_Width - 26, 44+textHeight+8) stringText:string2 height:textHeight];
        }
        [self.blurEffect addEffectiVieAndAlterView:self.alterView];
    }else{
        _buttonDetail.showsTouchWhenHighlighted = YES;
        [self.alterView.superview removeFromSuperview];
    }
    
}
- (void)setProductName:(NSString *)productName
{
    _productName = productName;
    _productNamelabel.text = [NSString stringWithFormat:@"%@  最新持仓数",productName];
}


@end
