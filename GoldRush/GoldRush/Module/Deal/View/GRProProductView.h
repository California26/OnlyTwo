//
//  GRProProductView.h
//  GoldRush
//
//  Created by 徐孟林 on 2017/1/3.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol productDelegate <NSObject>

- (void)tapProductAction:(NSInteger)tag;

@end

@interface GRProProductView : UIScrollView

@property (nonatomic,strong) NSArray *aryCount;
@property (nonatomic,weak) id<productDelegate> tapdelegate;
@property (nonatomic,assign) BOOL isClose;//yes 休市中。no 没有休市中

@property (nonatomic,assign) NSInteger index;




@end
