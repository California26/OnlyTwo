
//
//  GRPriceView.m
//  GoldRush
//
//  Created by Jack on 2016/12/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRPriceView.h"
#import "GRRiseAnimationView.h"

@interface GRPriceView ()

@property (nonatomic, weak) UILabel *priceLabel;


@end

@implementation GRPriceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        self.priceLabel = label;
        label.text = self.price;
        label.font = [UIFont systemFontOfSize:35];
        label.textColor = [UIColor colorWithHexString:@"#ffffff"];
        
        label.frame = CGRectMake(0, 0, 110, 80);
        label.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setPrice:(NSString *)price{
    _price = price;
    self.priceLabel.text = price;
}

- (void)setIsRise:(BOOL)isRise{
    _isRise = isRise;
    GRRiseAnimationView *rise;
    if (self.isRise) {
        rise = [[GRRiseAnimationView alloc] initWithFrame:CGRectMake(110, 30, 20, 20) withImage:@"Rise_red" withDirection:AnimationDirectionFromBottomToTop];
    }else{
        rise = [[GRRiseAnimationView alloc] initWithFrame:CGRectMake(110, 30, 20, 20) withImage:@"Fall_Green" withDirection:AnimationDirectionFromTopToBottom];
    }
    [self addSubview:rise];
}

@end
