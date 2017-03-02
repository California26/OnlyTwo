//
//  GRSetPasswordScrollView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRSetPasswordScrollView;
@protocol GRSetPasswordScrollViewDelegate <NSObject>

@optional
- (void)updatePasswordAction;
- (void)getPasswordTextBeginWithTextField:(UITextField *)sender;
- (void)getPasswordTextEndWithTextField:(UITextField *)sender;
- (void)userProtocol;
- (void)JJ_getCode:(GRSetPasswordScrollView *)view didClickGetCodeBtn:(UIButton *)btn;

@end

@interface GRSetPasswordScrollView : UIScrollView

@property (nonatomic,weak)id<GRSetPasswordScrollViewDelegate> passwordDelegate;

@end
