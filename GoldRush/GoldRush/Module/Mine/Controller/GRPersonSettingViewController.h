//
//  GRPersonSettingViewController.h
//  GoldRush
//
//  Created by Jack on 2016/12/31.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRPersonSettingViewController : UIViewController

///返回选中的头像图片
@property (nonatomic, copy)  void(^settingBack)(UIImage *image);


@end
