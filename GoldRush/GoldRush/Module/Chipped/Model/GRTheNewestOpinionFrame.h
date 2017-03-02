//
//  GRTheNewestOpinionFrame.h
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GRTheNewestOpinion;
@interface GRTheNewestOpinionFrame : NSObject

///模型数据
@property(nonatomic, strong) GRTheNewestOpinion *opinionModel;

@property (nonatomic, assign, readonly) CGRect iconFrame;
@property (nonatomic, assign, readonly) CGRect nickFrame;
@property (nonatomic, assign, readonly) CGRect timeFrame;
@property (nonatomic, assign, readonly) CGRect titleFrame;
@property (nonatomic, assign, readonly) CGRect descFrame;
@property (nonatomic, assign, readonly) CGRect picture1Frame;
@property (nonatomic, assign, readonly) CGRect picture2Frame;
@property (nonatomic, assign, readonly) CGRect picture3Frame;

@property (nonatomic, assign, readonly) CGRect lineFrame;
@property (nonatomic, assign, readonly) CGRect likeBtnFrame;
@property (nonatomic, assign, readonly) CGRect commentBtnFrame;

@property (nonatomic, assign, readonly) CGFloat rowHeight;

///是否全部显示详情文字
@property (nonatomic, assign) BOOL isTotalShow;


@end
