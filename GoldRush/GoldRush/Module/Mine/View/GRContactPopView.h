//
//  GRContactPopView.h
//  GoldRush
//
//  Created by Jack on 2017/2/20.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRContactPopView;
@protocol GRContactPopViewDelegate <NSObject>

@optional
- (void)gr_contactPopView:(GRContactPopView *)popView clickBtn:(UIButton *)btn;

@end

@interface GRContactPopView : UIView

///
@property (nonatomic, weak) id<GRContactPopViewDelegate> delegate;

@end
