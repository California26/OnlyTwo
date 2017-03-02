//
//  GRPropertyResultView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/5.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ResultButtonActionDelegate <NSObject>

- (void)buttonBottomAction:(NSInteger)tag;

@end

@interface GRPropertyResultView : UIView

@property (nonatomic,weak)id<ResultButtonActionDelegate>delegate;
@end
