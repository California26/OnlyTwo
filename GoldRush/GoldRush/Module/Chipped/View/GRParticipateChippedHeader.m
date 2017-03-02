//
//  GRParticipateChippedHeader.m
//  GoldRush
//
//  Created by Jack on 2017/1/9.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRParticipateChippedHeader.h"

@interface GRParticipateChippedHeader ()

@property (nonatomic, weak) UIButton *selectedBtn;      ///选中按钮
@property (nonatomic, weak) UIButton *chippedButton;    ///合买按钮
@property (nonatomic, weak) UIButton *releaseButton;    ///发布按钮

@end

@implementation GRParticipateChippedHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //创建合买和发布按钮
        UIButton *chippedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:chippedBtn];
        [chippedBtn setTitle:@"合买" forState:UIControlStateNormal];
        [chippedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [chippedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [chippedBtn addTarget:self action:@selector(chippedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self chippedBtnClick:chippedBtn];
        
        UIButton *releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:releaseBtn];
        [releaseBtn setTitle:@"发布" forState:UIControlStateNormal];
        [releaseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [releaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [releaseBtn addTarget:self action:@selector(releaseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.releaseButton = releaseBtn;
        releaseBtn.backgroundColor = [UIColor whiteColor];
        
        //布局
        [chippedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.top.equalTo(self).offset(10);
            make.height.equalTo(@30);
            make.width.equalTo(releaseBtn.mas_width);
            make.right.equalTo(releaseBtn.mas_left);
        }];
        
        [releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-13);
            make.top.equalTo(self).offset(10);
            make.height.equalTo(@30);
            make.width.equalTo(chippedBtn.mas_width);
            make.left.equalTo(chippedBtn.mas_right);
        }];
    }
    return self;
}

#pragma mark - event response
- (void)chippedBtnClick:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    self.selectedBtn.backgroundColor = [UIColor whiteColor];
    btn.selected = YES;
    self.selectedBtn = btn;
    btn.backgroundColor = mainColor;
    
    if (self.btnBlock) {
        self.btnBlock(btn);
    }
}

- (void)releaseBtnClick:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    self.selectedBtn.backgroundColor = [UIColor whiteColor];
    btn.selected = YES;
    self.selectedBtn = btn;
    btn.backgroundColor = mainColor;
    
    if (self.btnBlock) {
        self.btnBlock(btn);
    }
}

@end
