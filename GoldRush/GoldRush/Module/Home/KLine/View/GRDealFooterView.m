//
//  GRDealFooterView.m
//  GoldRush
//
//  Created by Jack on 2016/12/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRDealFooterView.h"

@interface GRDealFooterView ()


@end

@implementation GRDealFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //创建底部按钮
        [self createBottomView];
        
    }
    return self;
}

//创建底部按钮
- (void)createBottomView{
    UIButton *rise = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:rise];
    [rise setTitle:@"买涨" forState:UIControlStateNormal];
    rise.backgroundColor = [UIColor colorWithHexString:@"#f1496c"];
    [rise setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rise.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    rise.layer.cornerRadius = 5;
    rise.layer.masksToBounds = YES;
    rise.tag = 100;
    [rise addTarget:self action:@selector(riseClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *fall = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:fall];
    fall.backgroundColor = [UIColor colorWithHexString:@"#09cb67"];
    [fall setTitle:@"买跌" forState:UIControlStateNormal];
    [fall setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    fall.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    fall.layer.cornerRadius = 5;
    fall.layer.masksToBounds = YES;
    [fall addTarget:self action:@selector(fallClick:) forControlEvents:UIControlEventTouchUpInside];
    fall.tag = 101;
    [rise mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(13);
        make.bottom.equalTo(@-10);
        make.height.equalTo(@40);
        make.width.equalTo(@((K_Screen_Width - 26 - 40) * 0.5));
    }];
    [fall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-13);
        make.bottom.equalTo(@-10);
        make.height.equalTo(@40);
        make.width.equalTo(@((K_Screen_Width - 26 - 40) * 0.5));
    }];
}


#pragma mark - event response
//买涨
- (void)riseClick:(UIButton *)btn{
    if (self.riseClick) {
        self.riseClick(btn);
    }
}

//买跌
- (void)fallClick:(UIButton *)btn{
    if (self.fallClick) {
        self.fallClick(btn);
    }
}


- (void)setIsClose:(BOOL)isClose
{
    _isClose = isClose;
    if (isClose) {
        for (UIButton *btn in self.subviews) {
            if (btn.tag == 100) {
                [btn removeTarget:self action:@selector(riseClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.backgroundColor = [UIColor lightGrayColor];
            }else{
                [btn removeTarget:self action:@selector(fallClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.backgroundColor = [UIColor lightGrayColor];
            }
        }
    }else{
        for (UIButton *btn in self.subviews) {
            if (btn.tag == 100) {
                [btn addTarget:self action:@selector(riseClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.backgroundColor = [UIColor colorWithHexString:@"#f1496c"];
            }else{
                [btn addTarget:self action:@selector(fallClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.backgroundColor = [UIColor colorWithHexString:@"#09cb67"];
            }
        }
    }
}


@end
