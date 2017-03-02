//
//  GRPropertyViewController.h
//  GoldRush
//
//  Created by Jack on 2016/12/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRPropertyViewController : UIViewController

@property (nonatomic,assign) NSInteger clickCurrentProductTag;///点击相应的产品
@property (nonatomic,strong) NSMutableArray                  *productListAry;//产品列表数据

@end
