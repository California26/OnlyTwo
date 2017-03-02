//
//  GRTimeTypeView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/16.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRTimeTypeView;

@protocol GRTimeTypeViewDelegate <NSObject>
//- (void)timeTypeWithView:(GRTimeTypeView *)segmentView clickSegementButtonIndex:(NSInteger)index;
- (void)timeTypeClickSegementButtonIndex:(NSInteger)index;

@end

@interface GRTimeTypeView : UIView

- (instancetype)initWithItems:(NSArray *)items;

@property (nonatomic,strong) NSArray *items;
@property (nonatomic,assign) id<GRTimeTypeViewDelegate> delegate;
@property (nonatomic,assign) NSUInteger selectedIndex;

@end
