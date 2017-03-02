//
//  GRNewHandSchoolFooterView.m
//  GoldRush
//
//  Created by Jack on 2016/12/24.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRNewHandSchoolFooterView.h"

#import "UIButton+GRButtonLayout.h"

#define btnWidth (K_Screen_Width / 4)
static CGFloat const btnheight = 100;
@interface GRNewHandSchoolFooterView ()

///按钮文字
@property(nonatomic, strong) NSMutableArray <NSString *>*textArray;
///按钮图片
@property(nonatomic, strong) NSMutableArray <NSString *>* imageArray;

@end

@implementation GRNewHandSchoolFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView{
    for (int i = 0; i < self.textArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.adjustsImageWhenHighlighted = NO;
        [btn setTitle:self.textArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = [UIColor whiteColor];
        btn.imageView.contentMode = UIViewContentModeCenter;
        if (iPhone5) {
            btn.titleRect = CGRectMake(10, 60, btnWidth, 30);
            btn.imageRect = CGRectMake(0, 0, btnWidth, btnheight - 30);
        }else if (iPhone6){
            btn.titleRect = CGRectMake(17, 60, btnWidth, 30);
            btn.imageRect = CGRectMake(0, 0, btnWidth, btnheight - 30);
        } else{
            btn.titleRect = CGRectMake(23, 60, btnWidth, 30);
            btn.imageRect = CGRectMake(0, 0, btnWidth, btnheight - 30);
        }
        [btn setImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(btnWidth * i, 10, btnWidth, btnheight);
        [btn addTarget:self action:@selector(newHandClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

#pragma mark - event response
- (void)newHandClick:(UIButton *)btn{
    if (self.newHandClick) {
        self.newHandClick(btn.titleLabel.text);
    }
}

#pragma mark - setter and getter
- (NSMutableArray *)textArray{
    if (!_textArray) {
        _textArray = [NSMutableArray arrayWithArray:@[@"新手学堂",@"最新活动",@"行情资讯",@"联系客服"]];
    }
    return _textArray;
}

- (NSMutableArray<NSString *> *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithArray:@[@"Home_School",@"Home_Balloon",@"Home_Market",@"Home_Service"]];
    }
    return _imageArray;
}

@end
