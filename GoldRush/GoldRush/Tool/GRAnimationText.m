//
//  GRAnimationText.m
//  GoldRush
//
//  Created by Jack on 2017/1/3.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRAnimationText.h"
#import "HeadLine.h"

@interface GRAnimationText ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) HeadLine *line;

@end

@implementation GRAnimationText

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
        self.titleLabel = label;
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"#d43c33"];
        
        HeadLine *headLine3 = [[HeadLine alloc]initWithFrame:CGRectMake(100, 0, K_Screen_Width - 120, 25)];
        self.line = headLine3;
        [headLine3 setBgColor:[UIColor clearColor] textColor:nil textFont:[UIFont systemFontOfSize:12]];
        [headLine3 setScrollDuration:0.5 stayDuration:3];
        [headLine3 changeTapMarqueeAction:^(NSInteger index) {
            GRLog(@"你点击了第 %ld 个button！内容：%@", index, headLine3.messageArray[index]);
            if (self.textClick) {
                self.textClick();
            }
        }];
        [self addSubview:label];
        [self addSubview:headLine3];
    }
    return self;
}

- (void)setText:(NSString *)text{
    _text = text;
    self.titleLabel.text = text;
}

- (void)setMessage:(NSMutableArray *)message{
    _message = message;
    for (int i = 0; i < message.count; i ++) {
        NSString *text = message[i];
        NSRange range;
        if ([_text isEqualToString:@"最新盈利"]) {
            range = [text stringSubWithString:@"利" andString:@"元"];
        }else //([_text isEqualToString:@"交易快报"])
        {
            range = [text stringSubWithString:@"多" andString:@"元"];
        }
        NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:text];
        [attribut addAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#d43c33"]} range:range];
        [message replaceObjectAtIndex:i withObject:attribut];
    }

    self.line.messageArray = message;
    [self.line start];
}

@end
