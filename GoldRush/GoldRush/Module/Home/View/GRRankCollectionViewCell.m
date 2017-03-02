//
//  GRRankCollectionViewCell.m
//  GoldRush
//
//  Created by Jack on 2016/12/23.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRRankCollectionViewCell.h"
/** 模型 */
#import "GRProfit.h"

@interface GRRankCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
@property (weak, nonatomic) IBOutlet UIImageView *medalImageView;

@end

@implementation GRRankCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;
}

- (void)setModel:(GRProfit *)model{
    _model = model;
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.url]];
    self.iconImageView.image = [UIImage imageNamed:model.url];
    self.nickNameLabel.text = model.nickName;
    self.profitLabel.text = model.profit;
    if ([model.rank isEqualToString:@"1"]) {
        self.medalImageView.hidden = NO;
        self.medalImageView.image = [UIImage imageNamed:@"Gold_Medal.png"];
    }else if ([model.rank isEqualToString:@"2"]){
        self.medalImageView.image =[UIImage imageNamed:@"Silver_Medal.png"];
    }else if ([model.rank isEqualToString:@"3"]){
        self.medalImageView.image = [UIImage imageNamed:@"Bronze_Medal.png"];
    }else{
        self.medalImageView.hidden = YES;
    }
}


@end
