//
//  GRAnalystCollectionViewCell.m
//  GoldRush
//
//  Created by Jack on 2016/12/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRAnalystCollectionViewCell.h"

@interface GRAnalystCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;

@end

@implementation GRAnalystCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.iconImageView.layer.cornerRadius = 38;
    self.iconImageView.layer.masksToBounds = YES;
    
}

- (IBAction)fellowClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
        
    if (!btn.selected) {
        btn.backgroundColor = [UIColor colorWithHexString:@"#f39800"];
    }else{
        btn.backgroundColor = [UIColor lightGrayColor];
    }
}


@end
