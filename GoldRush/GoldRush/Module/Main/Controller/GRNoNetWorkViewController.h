//
//  GRNoNetWorkViewController.h
//  GoldRush
//
//  Created by Jack on 2017/2/16.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GRNoNetWorkViewControllerDelegate <NSObject>

@optional
- (void)gr_noNetworkDidClickBtn:(UIButton *)btn;

@end

@interface GRNoNetWorkViewController : UIViewController

///
@property (nonatomic, weak) id<GRNoNetWorkViewControllerDelegate> delegate;

@end
