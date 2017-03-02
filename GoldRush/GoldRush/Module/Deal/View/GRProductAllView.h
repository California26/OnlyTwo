//
//  GRProductAllView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/4.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProductClickDelegate <NSObject>

- (void)clickProductAction:(NSInteger)tag;

@end

@interface GRProductAllView : UIView
@property (nonatomic,strong) NSArray *aryCount;
@property (nonatomic,assign) BOOL isClose;

@property (nonatomic,assign) id<ProductClickDelegate> delegate;

@property (nonatomic,assign) NSInteger index;


//- (instancetype)initWithFrame:(CGRect)frame arySource:(NSArray *)arySource;
@end
