//
//  GRDealHeader.m
//  GoldRush
//
//  Created by Jack on 2017/1/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRDealHeader.h"
#import "GRCreateCostBtn.h"
#import "GRRiseAnimationView.h"

#import "GRHDProductModel.h"        ///数据模型
#import "GRJJProductModel.h"

@interface GRDealHeader ()

///标题
@property (nonatomic, weak) UILabel *textLabel;
///价钱
@property (nonatomic, weak) UILabel *priceLabel;
///提示框
@property (nonatomic, weak) UILabel *tipLabel;
///下面的小三角
@property (nonatomic, weak) UIImageView *trangleImageView;

///选中的按钮
@property (nonatomic, weak) GRCreateCostBtn *selectedBtn;


///动画 view
@property (nonatomic, strong) GRRiseAnimationView *animationView;

@end

@implementation GRDealHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置子控件
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    UILabel *text = [[UILabel alloc] init];
    [self addSubview:text];
    text.font = [UIFont systemFontOfSize:13];
    text.textColor = [UIColor colorWithHexString:@"#333333"];
    self.textLabel = text;
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(13);
    }];
    
    UILabel *price = [[UILabel alloc] init];
    [self addSubview:price];
    price.textColor = [UIColor colorWithHexString:@"#f1496c"];
    price.font = [UIFont boldSystemFontOfSize:12];
    self.priceLabel = price;
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(text.mas_right).offset(3);
    }];
    
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13);
        make.right.equalTo(self.mas_right).offset(-13);
        make.height.equalTo(@1);
        make.width.equalTo(@(K_Screen_Width - 26));
        make.top.equalTo(text.mas_bottom).offset(8);
    }];
    
    UILabel *cost = [[UILabel alloc] init];
    [self addSubview:cost];
    cost.text = @"选择建仓成本";
    cost.textColor = [UIColor colorWithHexString:@"#666666"];
    cost.font = [UIFont boldSystemFontOfSize:11];
    [cost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13);
        make.top.equalTo(line.mas_bottom).offset(8);
    }];
    
    CGFloat width = (K_Screen_Width - 44 - 20) / 3;
    for (int i = 0; i < 3; i ++) {
        GRCreateCostBtn *costBtn = [[GRCreateCostBtn alloc] init];
        [self addSubview:costBtn];
        costBtn.layer.cornerRadius = 15;
        costBtn.layer.masksToBounds = YES;
        costBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        costBtn.frame = CGRectMake(22 + (width + 10) * i, 60, width, width);
        [costBtn addTarget:self action:@selector(costClick:) forControlEvents:UIControlEventTouchUpInside];
        costBtn.tag = 3456 + i;
        if (0 == i) {
            [self costClick:costBtn];
        }
    }
    
    //提示框
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(13, width + 60 + 9, K_Screen_Width - 26, 30)];
    [self addSubview:tip];
    self.tipLabel = tip;
    tip.text = @"  全民淘金";
    tip.layer.cornerRadius = 6;
    tip.layer.masksToBounds = YES;
    tip.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    tip.textColor = [UIColor blackColor];
    tip.font = [UIFont systemFontOfSize:12];
    
    //按钮下边的小三角
    UIImageView *trangle = [[UIImageView alloc] initWithFrame:CGRectMake(self.selectedBtn.center.x - 10, self.selectedBtn.frame.origin.y + self.selectedBtn.frame.size.height, 15, 9)];
    [self addSubview:trangle];
    self.trangleImageView = trangle;
    trangle.image = [UIImage imageNamed:@"Trangle"];

}

#pragma mark - private method
- (void)costClick:(GRCreateCostBtn *)btn{
    self.selectedBtn.selected = NO;
    self.selectedBtn.isShowTicket = NO;
    self.selectedBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    btn.selected = YES;
    self.selectedBtn = btn;
    btn.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
    self.trangleImageView.frame = CGRectMake(self.selectedBtn.center.x - 10, self.selectedBtn.frame.origin.y + self.selectedBtn.frame.size.height, 15, 9);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(gr_dealHeaderView:didProductBtn:)]) {
        [self.delegate gr_dealHeaderView:self didProductBtn:btn];
    }
}


#pragma mark - setter and getter
- (void)setProductArray:(NSMutableArray *)productArray{
    _productArray = productArray;
    if (productArray.count) {
        if ([self.productName isEqualToString:HD_ProductName]) {
            for (int i = 0; i < 3; i ++) {
                GRCreateCostBtn *costBtn = [self viewWithTag:i + 3456];
                GRHDProductModel *model = productArray[i];
                costBtn.product = [NSString stringWithFormat:@"%.1f%@%@",model.weight,model.spec,model.name];
                costBtn.market = [NSString stringWithFormat:@"行情1点是%.1f元",model.plRatio];
                [costBtn setTitle:[NSString stringWithFormat:@"¥%.0f",model.price] forState:UIControlStateNormal];
            }
        }else{
            for (int i = 0; i < 3; i ++) {
                GRCreateCostBtn *costBtn = [self viewWithTag:i + 3456];
                GRJJProductModel *model = productArray[i];
                costBtn.product = [NSString stringWithFormat:@"%@%@",model.specifications,model.productName];
                costBtn.market = [NSString stringWithFormat:@"行情1点是%.2f元",model.floatProfit.floatValue];
                [costBtn setTitle:[NSString stringWithFormat:@"¥%.0f",model.unitPrice.floatValue] forState:UIControlStateNormal];
            }
        }
    }
    
}

- (void)setProductName:(NSString *)productName{
    _productName = productName;
    self.textLabel.text = productName;
    
}

- (void)setIsRise:(BOOL)isRise{
    _isRise = isRise;
    if (self.isRise) {  ///涨
        self.animationView.animationDirection = AnimationDirectionFromBottomToTop;
        self.priceLabel.textColor = [UIColor colorWithHexString:@"#f1496c"];
    }else{          ///跌
        self.animationView.animationDirection = AnimationDirectionFromTopToBottom;
        self.priceLabel.textColor = [UIColor colorWithHexString:@"#09cb67"];
    }
    [self addSubview:self.animationView];
}

- (GRRiseAnimationView *)animationView{
    if (!_animationView) {
        _animationView = [[GRRiseAnimationView alloc] initWithFrame:CGRectMake(110, 10, 20, 20)];
    }
    return _animationView;
}

- (void)setProductPrice:(NSString *)productPrice{
    _productPrice = productPrice;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",productPrice.floatValue];
}

- (void)setIsUseTicket:(BOOL)isUseTicket{
    _isUseTicket = isUseTicket;
    
    self.selectedBtn.isShowTicket = isUseTicket;
}

///默认选中第一个按钮
- (void)setDefaultSelected:(NSString *)defaultSelected{
    _defaultSelected = defaultSelected;
    
    if (defaultSelected) {
        GRCreateCostBtn *btn = [self viewWithTag:3456];
        [self costClick:btn];
    }
}


@end
