//
//  GRReplyCommentModel.m
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRReplyCommentModel.h"

@implementation GRReplyCommentModel

- (NSString *)all{
    if (_all == nil) {
        if (self.toName && self.toName.length > 0) {
            _all = [NSString stringWithFormat:@"%@回复%@: %@", self.fromName, self.toName, self.desc];
        }else{
            _all = [NSString stringWithFormat:@"%@: %@", self.fromName, self.desc];
        }
    }
    return _all;
}

@end
