//
//  GRPlanIntroduceCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRPlanIntroduceCell.h"
#import "GRJoinPlan.h"

@interface GRPlanIntroduceCell ()

@property (nonatomic, assign) CGFloat descHeight;

///标题
@property (nonatomic, weak) UILabel *titleLabel;
///资金门槛
@property (nonatomic, weak) UILabel *thresholdLabel;
///详情介绍
@property (nonatomic, weak) UILabel *descLabel;

@end

@implementation GRPlanIntroduceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //计划名称
        UILabel *title = [[UILabel alloc] init];
        [self.contentView addSubview:title];
        self.titleLabel = title;
        title.text = @"郑成功起航计划";
        title.textColor = [UIColor colorWithHexString:@"#333333"];
        title.font = [UIFont systemFontOfSize:14];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.contentView).offset(11);
        }];
        
        //资金门槛
        UILabel *threshold = [[UILabel alloc] init];
        [self.contentView addSubview:threshold];
        self.thresholdLabel = threshold;
        threshold.text = @"资金门槛5千";
        threshold.backgroundColor = [UIColor colorWithHexString:@"#f19149"];
        threshold.textColor = [UIColor whiteColor];
        threshold.font = [UIFont systemFontOfSize:10];
        [threshold mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).offset(15);
            make.top.equalTo(self.contentView).offset(8);
        }];
        
        //详情介绍
        UILabel *desc = [[UILabel alloc] init];
        [self.contentView addSubview:desc];
        self.descLabel = desc;
        desc.text = @"发达的算法的手法第三方士大夫但是归根结底是开发环境;快速减肥;山东会计法开始减肥快和我一日而华为;客人好好护肤就是的风景的还是非计划的萨菲黄金的手法还是带符号;发货的手法可适当发货撒谎的饭卡号发货速度快回复就是;好的客服哈的身份卡;后付款哈速度快;合法化的首付款还是打款发货的爽肤水的反馈说地方哈市的减肥哈市了地方哈就是的房间按双方就阿訇了卡号发进来回复发货的时间和房价开始的放假哈记得符合无一日爱疯电费卡就是对方就可获得发货撒谎的反馈技术的发生纠纷和的活动时间发和大家是伐啦还是地方阿萨德符合我也特然后发货快点上飞狐额已入土为入口;啥积分多少;开发商的费覅;方法见客户的手机号购房款及水电费发的哈时候发货速度符合我要惹我一玉兔挖法规定时间发多少发";
        desc.textColor = [UIColor colorWithHexString:@"#666666"];
        desc.font = [UIFont systemFontOfSize:11];
        desc.numberOfLines = 0;
        [desc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
        }];
        self.rowHeight = [self heightWithString:self.descLabel.text];
    }
    return self;
}

- (void)setModel:(GRJoinPlan *)model{
    _model = model;
    
    self.titleLabel.text = model.name;
    self.thresholdLabel.text = model.warn;
    self.descLabel.text = model.number;
    
    self.rowHeight = [self heightWithString:self.descLabel.text];
}

- (CGFloat)heightWithString:(NSString *)string{
    return [string boundingRectWithSize:CGSizeMake(K_Screen_Width - 26, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRPlanIntroduceCell";
    GRPlanIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRPlanIntroduceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
