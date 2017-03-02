//
//  GRCreateCostBtn.m
//  GoldRush
//
//  Created by Jack on 2017/1/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRCreateCostBtn.h"

@interface GRCreateCostBtn ()

///产品介绍
@property (nonatomic, weak) UILabel *productLabel;
///行情
@property (nonatomic, weak) UILabel *marketLabel;
///券
@property (nonatomic, weak) UIImageView *ticketImageView;

@end

@implementation GRCreateCostBtn

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置字体
        self.titleLabel.font = [UIFont boldSystemFontOfSize:25];
        
        //产品介绍
        UILabel *product = [[UILabel alloc] init];
        self.productLabel = product;
        [self addSubview:product];
        product.font = [UIFont boldSystemFontOfSize:11];
        product.textColor = [UIColor whiteColor];
        
        //行情
        UILabel *market = [[UILabel alloc] init];
        [self addSubview:market];
        self.marketLabel = market;
        market.font = [UIFont boldSystemFontOfSize:10];
        market.textColor = [UIColor whiteColor];
        
        [product mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(-15);
        }];
        
        [market mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).offset(-8);
        }];
        
        //券
        UIImageView *image = [[UIImageView alloc] init];
        [self addSubview:image];
        image.hidden = YES;
        self.ticketImageView = image;
        image.image = [UIImage imageNamed:@"Deal_Ticket"];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.right.equalTo(self).offset(-5);
            make.width.and.height.equalTo(@18);
        }];

    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    //画虚线
    //获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 1);
    const CGPoint line[] = {CGPointMake(0, rect.size.height * 0.73),CGPointMake(rect.size.width, rect.size.height * 0.73)};
    //设置虚线
    CGFloat lengths[] = {2,2};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextStrokeLineSegments(context, line, 2);

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin.y = 8;
    self.titleLabel.frame = titleRect;

}

- (void)setProduct:(NSString *)product{
    _product = product;
    self.productLabel.text = product;
}

- (void)setMarket:(NSString *)market{
    _market = market;
    self.marketLabel.text = market;
}

- (void)setIsShowTicket:(BOOL)isShowTicket{
    _isShowTicket = isShowTicket;
    if (isShowTicket) {
        self.ticketImageView.hidden = NO;
    }else{
        self.ticketImageView.hidden = YES;
    }
}

@end
