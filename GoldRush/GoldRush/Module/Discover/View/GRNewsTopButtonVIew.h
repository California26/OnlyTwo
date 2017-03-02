//
//  GRNewsTopButtonVIew.h
//  GoldRush
//
//  Created by Jack on 2017/2/15.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GRNewsTopButtonVIewDelegate <NSObject>

@optional
- (void)gr_clickNewTopButton:(UIButton *)btn;

@end

@interface GRNewsTopButtonVIew : UIView

@property (nonatomic, weak) id<GRNewsTopButtonVIewDelegate> delegate;

@end
