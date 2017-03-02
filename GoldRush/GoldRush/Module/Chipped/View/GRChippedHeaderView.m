//
//  GRHeaderView.m
//  GoldRush
//
//  Created by Jack on 2016/12/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#define LineWidth 60

#import "GRChippedHeaderView.h"

@interface GRChippedHeaderView ()

@property(nonatomic, strong) UIButton *selectedBtn;     ///选中的按钮
@property (nonatomic, weak) UIImageView *lineView;      ///左边按钮下边的线

@property (nonatomic, weak) UIButton *analystBtn;
@property (nonatomic, weak) UIButton *documentaryBtn;


@end

@implementation GRChippedHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置 UI
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    //分析师
    UIButton *analyst = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:analyst];
    analyst.selected = YES;
    self.analystBtn = analyst;
    [analyst setTitle:@"分析师" forState:UIControlStateNormal];
    [analyst setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [analyst addTarget:self action:@selector(analystClick:) forControlEvents:UIControlEventTouchUpInside];
    [analyst setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self analystClick:analyst];
    
    //跟单
    UIButton *documentary = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:documentary];
    self.documentaryBtn = documentary;
    [documentary setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [documentary setTitle:@"全民跟单" forState:UIControlStateNormal];
    [documentary addTarget:self action:@selector(documentaryClick:) forControlEvents:UIControlEventTouchUpInside];
    [documentary setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

    
    [analyst mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(self);
        make.width.equalTo(documentary.mas_width);
        make.right.equalTo(documentary.mas_left);
    }];
    [documentary mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(analyst.mas_right);
        make.top.and.right.and.bottom.equalTo(self);
        make.width.equalTo(analyst.mas_width);
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    [self addSubview:line];
    line.image = [UIImage imageNamed:@"Chipped_Red_Line"];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(analyst.mas_bottom);
        make.centerX.equalTo(analyst.mas_centerX);
    }];
    self.lineView = line;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = GRColor(220, 220, 220);
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@1);
    }];
}

- (void)analystClick:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.lineView.frame = CGRectMake(K_Screen_Width * 0.25 - 30, 27, self.lineView.frame.size.width, self.lineView.frame.size.height);
    }];
    if (self.analstBlock) {
        self.analstBlock(btn);
    }
}

- (void)documentaryClick:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.lineView.frame = CGRectMake(K_Screen_Width * 0.75 - 30, 27, self.lineView.frame.size.width, self.lineView.frame.size.height);
    }];
    if (self.documentaryBlock) {
        self.documentaryBlock(btn);
    }
}

@end
