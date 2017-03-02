//
//  GRNewHandSchoolFooterView.h
//  GoldRush
//
//  Created by Jack on 2016/12/24.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRNewHandSchoolFooterView : UIView

///点击那个按钮
@property (nonatomic, copy) void(^newHandClick)(NSString *type);


@end
