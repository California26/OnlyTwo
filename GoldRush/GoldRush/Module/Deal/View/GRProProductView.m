//
//  GRProProductView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/3.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRProProductView.h"//点击和没点击产品总的视图
#import "GRProductView.h"//没有点击产品的视图
#import "GRProductClickView.h"//点击产品的视图
#import "KLineConstant.h"

#define productHeight 51
@interface GRProProductView ()
{
    CGFloat ClickWidth;
    CGFloat noClickWidth;
}


@property (nonatomic,strong) NSMutableArray *aryFirst;
@property (nonatomic,strong) NSMutableArray *arySecond;
@property (nonatomic,strong) GRProductClickView *clickView;
@property (nonatomic,strong) UIView *leftDownView;//左右阴影视图
@property (nonatomic,strong) UIView *rightDownView;
@property (nonatomic,assign) int Numbers;
@property (nonatomic,assign) int tapNumber;


@end

@implementation GRProProductView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _Numbers = 0;
        _tapNumber = 0;
        if (iPhone5) {
            ClickWidth = 125;
        }else if (iPhone6)
        {
            ClickWidth = 136.5;
        }else{
            ClickWidth = 190;
        }
        noClickWidth = (K_Screen_Width-ClickWidth)/2.5;
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        _aryFirst = [NSMutableArray array];
        _arySecond = [NSMutableArray array];
        _clickView = [[GRProductClickView alloc] initWithFrame:CGRectMake(0, 0, ClickWidth, productHeight)];
        _clickView.tag = 1000;
        [self addSubview:_clickView];
    }
    return self;
}

- (void)setAryCount:(NSArray *)aryCount
{
    _aryCount = aryCount;
    self.contentSize = CGSizeMake(ClickWidth+noClickWidth*(_aryCount.count-1), productHeight);
    for (int i = 0; i<_aryCount.count; i++) {
            if (_Numbers > 0) {
                _clickView.title = _aryCount[_tapNumber][@"title"];
                _clickView.number = _aryCount[_tapNumber][@"number"];
                _clickView.stringLeft = _aryCount[_tapNumber][@"left"];
                if ([_clickView.stringLeft containsString:@"-"]) {
                    _clickView.isUpOrDown = NO;
                }else{
                    _clickView.isUpOrDown = YES;
                }
                _clickView.stringRight = _aryCount[_tapNumber][@"right"];
                
                GRProductView *productView = [self viewWithTag:i+10];
                productView.title = _aryCount[i][@"title"];
                productView.number = _aryCount[i][@"number"];
                NSString *stringLeft = _aryCount[i][@"left"];
                if ([stringLeft containsString:@"-"]) {
                    productView.isUpOrDown = NO;
                }else{
                    productView.isUpOrDown = YES;
                }
                
            }else{
                if (i <= _tapNumber) {
                    _clickView.title = _aryCount[_tapNumber][@"title"];
                    _clickView.number = _aryCount[_tapNumber][@"number"];
                    _clickView.stringLeft = _aryCount[_tapNumber][@"left"];
                    if ([_clickView.stringLeft containsString:@"-"]) {
                        _clickView.isUpOrDown = NO;
                    }else{
                        _clickView.isUpOrDown = YES;
                    }
                    _clickView.stringRight = _aryCount[_tapNumber][@"right"];
                    _clickView.frame = CGRectMake(noClickWidth*(_tapNumber)-3, 0, ClickWidth, productHeight);
                    [self bringSubviewToFront:self.clickView];
                    GRProductView *productView = [[GRProductView alloc] initWithFrame:CGRectMake(noClickWidth*(i), 0, noClickWidth, productHeight)];
                    productView.tag = i+10;
                    productView.title = _aryCount[i][@"title"];
                    productView.number = _aryCount[i][@"number"];
                    NSString *stringLeft = _aryCount[i][@"left"];
                    if ([stringLeft containsString:@"-"]) {
                        productView.isUpOrDown = NO;
                    }else{
                        productView.isUpOrDown = YES;
                    }
                    [self insertSubview:productView belowSubview:_clickView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                    [productView addGestureRecognizer:tap];
                    [self.aryFirst addObject:productView];
                }else{
                    GRProductView *productView = [[GRProductView alloc] initWithFrame:CGRectMake(ClickWidth+noClickWidth*(i-1), 0, noClickWidth, productHeight)];
                    productView.tag = i+10;
                    productView.title = _aryCount[i][@"title"];
                    productView.number = _aryCount[i][@"number"];
                    NSString *left = _aryCount[i][@"left"];
                    if ([left containsString:@"-"]) {
                        productView.isUpOrDown = NO;
                    }else{
                        productView.isUpOrDown = YES;
                    }
                    [self addSubview:productView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                    [productView addGestureRecognizer:tap];
                    [self.arySecond addObject:productView];

                }
                
            }
    }
    if (_Numbers>0) {
        
    }else{
        [self addSubview:self.leftDownView];
        [self addSubview:self.rightDownView];
    }
    _Numbers ++ ;
}

- (UIView *)leftDownView
{
    if (!_leftDownView) {
        _leftDownView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-2, noClickWidth*3, 2)];
        _leftDownView.backgroundColor = [UIColor clearColor];
        UIBezierPath *shadowPathLeft = [UIBezierPath bezierPathWithRect:_leftDownView.bounds];
        _leftDownView.layer.masksToBounds = NO;
        _leftDownView.layer.shadowColor = [UIColor blackColor].CGColor;
        _leftDownView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
        _leftDownView.layer.shadowOpacity = 0.5f;
        _leftDownView.layer.shadowPath = shadowPathLeft.CGPath;
    }
    return _leftDownView;
}

- (UIView *)rightDownView
{
    if (!_rightDownView) {
        _rightDownView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_clickView.frame), CGRectGetMinY(_leftDownView.frame), K_Screen_Width-CGRectGetWidth(_clickView.frame)/2, 2)];
        _rightDownView.backgroundColor = [UIColor clearColor];
        UIBezierPath *shadowPathRight = [UIBezierPath bezierPathWithRect:_rightDownView.bounds];
        _rightDownView.layer.masksToBounds = NO;
        _rightDownView.layer.shadowColor = [UIColor blackColor].CGColor;
        _rightDownView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
        _rightDownView.layer.shadowOpacity = 0.5f;
        _rightDownView.layer.shadowPath = shadowPathRight.CGPath;
    }
    return _rightDownView;
}
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    [self changeProductWithTag:(sender.view.tag-10)];
    if (self.tapdelegate && [self.tapdelegate respondsToSelector:@selector(tapProductAction:)]) {
        [self.tapdelegate tapProductAction:sender.view.tag];
    }
}

- (void)changeProductWithTag:(NSInteger)tagSelect
{
    _clickView.frame = CGRectMake(noClickWidth*(tagSelect)-3, 0, ClickWidth, productHeight);
    _clickView.title = _aryCount[tagSelect][@"title"];
    _clickView.number = _aryCount[tagSelect][@"number"];
    _clickView.stringLeft = _aryCount[tagSelect][@"left"];
    if ([_clickView.stringLeft containsString:@"-"]) {
        _clickView.isUpOrDown = NO;
    }else{
        _clickView.isUpOrDown = YES;
    }
    _clickView.stringRight = _aryCount[tagSelect][@"right"];
    [self bringSubviewToFront:_clickView];
    _leftDownView.frame = CGRectMake(0, self.frame.size.height-2, noClickWidth*(tagSelect), 2);
    _rightDownView.frame = CGRectMake(CGRectGetMaxX(_clickView.frame), CGRectGetMinY(_leftDownView.frame), self.contentSize.width-CGRectGetWidth(_leftDownView.frame)-CGRectGetWidth(_clickView.frame), 2);
    int leftTag = (int)((UIView *)_aryFirst.lastObject).tag;
    UIView *leftView = (UIView *)_aryFirst.lastObject;
    NSInteger absoluteTag = labs(tagSelect+10-leftTag);
    for (int i = 0; i<absoluteTag; i++) {
        if (leftTag > tagSelect+10) {
            [_arySecond insertObject:_aryFirst.lastObject atIndex:0];
            [_aryFirst removeLastObject];
            ((UIView *)_arySecond.firstObject).frame = CGRectMake(ClickWidth+(_aryFirst.count-1)*noClickWidth, CGRectGetMinY(leftView.frame), CGRectGetWidth(leftView.frame), CGRectGetHeight(leftView.frame));
        }else{
            UIView *view = self.arySecond.firstObject;
            view.frame = CGRectMake(CGRectGetMaxX(((UIView *)self.aryFirst.lastObject).frame), CGRectGetMinY(leftView.frame), CGRectGetWidth(leftView.frame), CGRectGetHeight(leftView.frame));
            [self.aryFirst addObject:view];
            [self.arySecond removeObject:view];
        }
    }
    if (tagSelect + 10 == 13) {
        self.contentOffset = CGPointMake(noClickWidth/2, 0);
    }else if(tagSelect + 10 == 10){
        self.contentOffset = CGPointMake(0, 0);
    }

}
- (void)setIsClose:(BOOL)isClose
{
    _isClose = isClose;
    for (UIView *view in self.subviews) {
        if (view.tag == 1000) {
            ((GRProductClickView *)view).isClose = isClose;
        }else if([view isKindOfClass:[GRProductView class]]){
            ((GRProductView *)view).isClose = isClose;
        }
    }
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    if (index || self.aryCount.count >0 ) {
        _tapNumber = (int)index;
        [self changeProductWithTag:index];
    }
}
@end
