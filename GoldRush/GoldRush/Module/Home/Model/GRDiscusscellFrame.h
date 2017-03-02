//
//  GRDiscusscellFrame.h
//  GoldRush
//
//  Created by Jack on 2016/12/30.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GRDiscussModel;
@interface GRDiscusscellFrame : NSObject

///模型数据
@property(nonatomic, strong) GRDiscussModel *discussModel;

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

@property (nonatomic, assign, readonly) CGFloat rowHeight;

@end
