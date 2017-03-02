//
//  GRCloseAlterView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CloseAlterDelegate <NSObject>

- (void)closeAlterButton:(UIButton *)sender;

@end

@interface GRCloseAlterView : UIView

- (instancetype)initWithFrame:(CGRect)frame stringKinds:(NSString *)stringKinds stringNew:(NSString *)stringNew stringWin:(NSString *)stringWin;

@property (nonatomic,weak)id<CloseAlterDelegate> delegate;
@end
