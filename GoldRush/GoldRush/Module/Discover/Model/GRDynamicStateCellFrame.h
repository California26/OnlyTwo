//
//  GRDynamicStateCellFrame.h
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GRDynamicStateModel;
@interface GRDynamicStateCellFrame : NSObject

///模型数据
@property(nonatomic, strong) GRDynamicStateModel *dynamicModel;
///评论的 cell
@property (nonatomic, strong) NSArray *commentCellFrame;

@property (nonatomic, assign, readonly) CGRect iconFrame;
@property (nonatomic, assign, readonly) CGRect nickFrame;
@property (nonatomic, assign, readonly) CGRect timeFrame;
@property (nonatomic, assign, readonly) CGRect phoneFrame;
@property (nonatomic, assign, readonly) CGRect descFrame;
@property (nonatomic, assign, readonly) CGRect picture1Frame;
@property (nonatomic, assign, readonly) CGRect picture2Frame;
@property (nonatomic, assign, readonly) CGRect picture3Frame;

@property (nonatomic, assign, readonly) CGRect lineFrame;
@property (nonatomic, assign, readonly) CGRect likeBtnFrame;
@property (nonatomic, assign, readonly) CGRect commentBtnFrame;

///tableview 的 frame
@property (nonatomic, assign, readonly) CGRect tableViewFrame;

@property (nonatomic, assign, readonly) CGFloat rowHeight;

@end
