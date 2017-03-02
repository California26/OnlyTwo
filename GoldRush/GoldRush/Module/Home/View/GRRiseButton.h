//
//  GRRiseButton.h
//  GoldRush
//
//  Created by Jack on 2016/12/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, PriceLabelColor) {
    PriceLabelColorGray,
    PriceLabelColorRed,
    PriceLabelColorGreen
};

@interface GRRiseButton : UIButton

///颜色类型
@property (nonatomic, assign) PriceLabelColor colorType;
///价格
@property (nonatomic, strong) NSDictionary *priceDict;
///是否显示休市标签
@property (nonatomic, assign) BOOL isShowClose;

@property (strong, nonatomic) UIColor *shimmerColor;            // 闪烁颜色，默认白


- (void)startShimmer;

- (void)stopShimmer;

@end
