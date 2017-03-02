//
//  GRRiseButton.m
//  GoldRush
//
//  Created by Jack on 2016/12/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRRiseButton.h"
#import "UICountingLabel.h"

@interface GRRiseButton ()

///休市显示
@property (nonatomic, weak) UILabel *closeLabel;
///价格
@property (nonatomic, weak) UICountingLabel *priceLabel;

@property (nonatomic, weak) UICountingLabel *profitLossLabel;
@property (nonatomic, weak) UICountingLabel *rateLabel;

@property (nonatomic, strong) UIView *maskView;
@property (strong, nonatomic) CAGradientLayer *maskLayer;
@property (strong, nonatomic) CABasicAnimation *alphaAni;   // alpha 动画
@property (assign, nonatomic) BOOL isPlaying;               // 正在播放动画
@property (assign, nonatomic) CGSize charSize;              // 文字 size

@end

@implementation GRRiseButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //休市
        UILabel *label = [[UILabel alloc] init];
        label.text = @"休市中";
        label.textColor = [UIColor colorWithHexString:@"#ffffff"];
        label.backgroundColor = [UIColor colorWithHexString:@"#dcdada"];
        [self addSubview:label];
        self.closeLabel = label;
        label.font = [UIFont systemFontOfSize:9];
        label.layer.cornerRadius = 5;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(3);
            make.top.equalTo(self.mas_top).offset(10);
            make.width.equalTo(@30);
            make.height.equalTo(@15);
        }];
        
        //价钱
        UICountingLabel *priceLabel = [[UICountingLabel alloc] init];
        priceLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:priceLabel];
        self.priceLabel = priceLabel;
        priceLabel.format = @"%zd";
        
        ///设置按钮文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        //涨幅
        UICountingLabel *riseLabel = [[UICountingLabel alloc] init];
        self.profitLossLabel = riseLabel;
        riseLabel.textColor = [UIColor colorWithHexString:@"#f1496c"];
        riseLabel.font = [UIFont systemFontOfSize:10];
        riseLabel.textAlignment = NSTextAlignmentCenter;
        riseLabel.format = @"%.2f";
        
        [self addSubview:riseLabel];
        [riseLabel sizeToFit];
        
        //百分比
        UICountingLabel *percentLabel = [[UICountingLabel alloc] init];
        percentLabel.textColor = [UIColor colorWithHexString:@"#f1496c"];
        percentLabel.font = [UIFont systemFontOfSize:10];
        self.rateLabel = percentLabel;
        percentLabel.format = @"%.2f";
        percentLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:percentLabel];
        [percentLabel sizeToFit];
        
        [riseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (iPhone5) {
                make.left.equalTo(self.mas_left).offset(5);
            }else{
                make.left.equalTo(self.mas_left).offset(15);
            }
            make.top.equalTo(priceLabel.mas_bottom).offset(10);
            make.right.equalTo(percentLabel.mas_left);
            make.width.equalTo(percentLabel.mas_width);
        }];
        
        [percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(priceLabel.mas_bottom).offset(10);
            if (iPhone5) {
                make.right.equalTo(self.mas_right).offset(-5);
            }else{
                make.right.equalTo(self.mas_right).offset(-15);
            }
            make.left.equalTo(riseLabel.mas_right);
            make.width.equalTo(riseLabel.mas_width);
        }];
        
        // 进入前台恢复动画
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
        
        ///初始化数据
        self.shimmerColor = [UIColor whiteColor];
        self.isPlaying = NO;
        self.charSize = self.bounds.size;
        [self addSubview:self.maskView];
    }
    return self;
}

//重新布局按钮
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin.y = 15;
    if (iPhone5) {
        if (self.isShowClose) {
            titleRect.origin.x = titleRect.origin.x - 10;
            
            CGRect priceFrame = self.priceLabel.frame;
            priceFrame.origin.x = priceFrame.origin.x - 10;
            self.priceLabel.frame = priceFrame;
            
            CGRect closeFrame = self.closeLabel.frame;
            closeFrame.origin.x = closeFrame.origin.x - 10;
            self.closeLabel.frame = closeFrame;
        }
    }
    self.titleLabel.frame = titleRect;
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.titleLabel.mas_centerX);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(-10);
    }];
    
    self.maskView.frame = self.bounds;
    self.maskLayer.frame = CGRectMake(0, 0, self.charSize.width, self.charSize.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return [super titleRectForContentRect:contentRect];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return [super imageRectForContentRect:contentRect];
}

#pragma mark - setter and getter
- (void)setIsShowClose:(BOOL)isShowClose{
    _isShowClose = isShowClose;
    if (isShowClose) {
        self.closeLabel.hidden = NO;
    }else{
        self.closeLabel.hidden = YES;
    }
}

- (void)setPriceDict:(NSDictionary *)priceDict{
    _priceDict = priceDict;
    self.priceLabel.text = [NSString stringWithFormat:@"%@",priceDict[@"theNewestPrice"]];
    NSString *rate = priceDict[@"profitAndLossRate"];
    self.rateLabel.text = [NSString stringWithFormat:@"%.2f%%",rate.floatValue];
    self.profitLossLabel.text = priceDict[@"profitAndLoss"];
}

- (void)setColorType:(PriceLabelColor)colorType{
    _colorType = colorType;
    if (colorType == PriceLabelColorGray) {
        self.priceLabel.textColor = [UIColor colorWithHexString:@"#dcdada"];
        self.profitLossLabel.textColor = [UIColor colorWithHexString:@"#dcdada"];
        self.rateLabel.textColor = [UIColor colorWithHexString:@"#dcdada"];
    }else if (colorType == PriceLabelColorRed){
        self.priceLabel.textColor = [UIColor colorWithHexString:@"#f1496c"];
        self.profitLossLabel.textColor = [UIColor colorWithHexString:@"#f1496c"];
        self.rateLabel.textColor = [UIColor colorWithHexString:@"#f1496c"];
    }else if (colorType == PriceLabelColorGreen){
        self.priceLabel.textColor = [UIColor colorWithHexString:@"#09cb67"];
        self.profitLossLabel.textColor = [UIColor colorWithHexString:@"#09cb67"];
        self.rateLabel.textColor = [UIColor colorWithHexString:@"#09cb67"];
    }
}

#pragma mark - 闪烁动画
#pragma mark - 属性 set, get 方法
- (UIView *)maskView {
    if (_maskView == nil) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.hidden = YES;
        _maskView.alpha = 0.85;
    }
    return _maskView;
}

- (CALayer *)maskLayer {
    if (_maskLayer == nil) {
        _maskLayer = [[CAGradientLayer alloc] init];
        _maskLayer.backgroundColor = [UIColor clearColor].CGColor;
        [self freshMaskLayer];
    }
    return _maskLayer;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    
    self.charSize = self.bounds.size;
    [self update];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state{
    [super setTitleColor:color forState:state];
    
    self.charSize = self.bounds.size;
    [self update];
}

- (void)setShimmerColor:(UIColor *)shimmerColor {
    if (_shimmerColor == shimmerColor) return ;
    _shimmerColor = shimmerColor;
    self.maskView.backgroundColor = shimmerColor;
    [self update];
}

- (void)update {
    if (self.isPlaying) {       // 如果在播放动画，更新动画
        [self stopShimmer];
        [self startShimmer];
    }
}

// 刷新 maskLayer 属性值, transform 值
- (void)freshMaskLayer {
    _maskLayer.backgroundColor = self.shimmerColor.CGColor;
    _maskLayer.colors = nil;
    _maskLayer.locations = nil;
}

#pragma mark - 其他方法
- (CABasicAnimation *)alphaAni {
    if (_alphaAni == nil) {
        _alphaAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _alphaAni.repeatCount = MAXFLOAT;
        _alphaAni.autoreverses = true;
        _alphaAni.fromValue = @(0.0);
        _alphaAni.toValue = @(1.0);
    }
    _alphaAni.duration = 0.5;
    return _alphaAni;
}

- (void)startShimmer {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 切换到主线程串行队列，下面代码打包成一个事件（原子操作），加到runloop，就不用担心 isPlaying 被多个线程同时修改
        // dispatch_async() 不 strong 持有本 block，也不用担心循环引用
        if (self.isPlaying == YES) return ;
        self.isPlaying = YES;
        
        self.maskView.hidden = NO;
        
        [self freshMaskLayer];
        self.maskView.layer.mask = self.maskLayer;
        
        self.maskLayer.transform = CATransform3DIdentity;
        [self.maskLayer removeAllAnimations];
        [self.maskLayer addAnimation:self.alphaAni forKey:@"start"];
    });
}

- (void)stopShimmer {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.isPlaying == NO) return ;
        self.isPlaying = NO;
        
        [self.maskLayer removeAllAnimations];
        [self.maskLayer removeFromSuperlayer];
        self.maskView.hidden = YES;
    });
}

- (void)willEnterForeground {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isPlaying = NO;
        [self startShimmer];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self stopShimmer];
        });
    });
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
