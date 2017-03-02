//
//  GRCountDownBtn.h
//  GoldRush
//
//  Created by Jack on 2016/12/21.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRCountDownBtn;
typedef NSString *(^DidChangeBlock)(GRCountDownBtn *countDownButton,int second);
typedef NSString *(^DidFinishedBlock)(GRCountDownBtn *countDownButton,int second);

typedef void (^TouchedDownBlock)(GRCountDownBtn *countDownButton,NSInteger tag);

@interface GRCountDownBtn : UIButton{
    int _second;
    int _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    DidChangeBlock _didChangeBlock;
    DidFinishedBlock _didFinishedBlock;
    TouchedDownBlock _touchedDownBlock;
}
- (void)addToucheHandler:(TouchedDownBlock)touchHandler;

- (void)didChange:(DidChangeBlock)didChangeBlock;
- (void)didFinished:(DidFinishedBlock)didFinishedBlock;
- (void)startWithSecond:(int)second;
- (void)stop;
@end
