//
//  GRProductAllView.m
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRProductAllView.h"
#import "GRProProductView.h"
#import "GRForthProductView.h"

@interface GRProductAllView ()<productDelegate>

@property (nonatomic,strong) GRForthProductView *forthView;
@property (nonatomic,strong) GRProProductView *proView;
@end

@implementation GRProductAllView

- (instancetype)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.proView = [[GRProProductView alloc]  initWithFrame:CGRectMake(0, 0, K_Screen_Width, 51)];
        [self addSubview:self.proView];
        self.proView.tapdelegate = self;
         self.forthView = [[GRForthProductView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.proView.frame)-3, K_Screen_Width, 25)];
        [self addSubview:self.forthView];
    }
    return self;
}

- (void)setAryCount:(NSArray *)aryCount
{
    if (aryCount.count != 0 && aryCount ) {
        _aryCount = aryCount;
        if (self.index) {
            _forthView.labelJK.text = _aryCount[self.index][@"today"];
            _forthView.labelZS.text = _aryCount[self.index][@"yesterday"];
            _forthView.labelZG.text = _aryCount[self.index][@"Highest"];
            _forthView.labelZD.text = _aryCount[self.index][@"lowest"];
        }else{
            _forthView.labelJK.text = _aryCount.firstObject[@"today"];
            _forthView.labelZS.text = _aryCount.firstObject[@"yesterday"];
            _forthView.labelZG.text = _aryCount.firstObject[@"Highest"];
            _forthView.labelZD.text = _aryCount.firstObject[@"lowest"];
        }
        self.proView.aryCount = aryCount;
    }
}

- (void)tapProductAction:(NSInteger)tag
{
    _forthView.labelJK.text = _aryCount[tag-10][@"today"];
    _forthView.labelZS.text = _aryCount[tag-10][@"yesterday"];
    _forthView.labelZG.text = _aryCount[tag-10][@"Highest"];
    _forthView.labelZD.text = _aryCount[tag-10][@"lowest"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickProductAction:)]) {
        [self.delegate clickProductAction:tag-10];
    }
}
- (void)setIsClose:(BOOL)isClose
{
    _isClose = isClose;
    _proView.isClose = isClose;
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    _proView.index = index;
}

@end
