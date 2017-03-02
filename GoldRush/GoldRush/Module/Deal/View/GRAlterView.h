//
//  GRAlterView.h
//  GoldRush
//
//  Created by 徐孟林 on 2016/12/29.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol alterDelegate <NSObject>

- (void)cancelAction;
- (void)startNewNumber;

@end

@interface GRAlterView : UIView

@property (nonatomic) id<alterDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame withArray:(NSArray<NSString *> *)text;
@end
