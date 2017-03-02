//
//  GRTheNewestOpinionCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/6.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRTheNewestOpinionCell.h"
#import "GRTheNewestOpinionFrame.h"
#import "UIView+GRExtension.h"
#import "GRTheNewestOpinion.h"

@interface GRTheNewestOpinionCell ()

/// 头像
@property (weak, nonatomic)  UIImageView *iconImage;
/// 昵称
@property (weak, nonatomic)  UILabel *nickLabel;
/// 描述
@property (weak, nonatomic)  UILabel *descLabel;
/// 时间
@property (weak, nonatomic)  UILabel *timeLabel;
/// 标题
@property (weak, nonatomic)  UILabel *titleLabel;
///分割线
@property (nonatomic, weak) UIView *lineView;
/// 评论
@property (weak, nonatomic)  UIButton *commentBtn;
/// 点赞
@property (weak, nonatomic)  UIButton *likeBtn;

/// 箭头
@property (weak, nonatomic)  UIImageView *arrowImage;

///显示的图片
@property (nonatomic, weak) UIImageView *picture1;
@property (nonatomic, weak) UIImageView *picture2;
@property (nonatomic, weak) UIImageView *picture3;

///点赞数
@property (nonatomic, assign) NSInteger countLike;


@end

@implementation GRTheNewestOpinionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子控件
        [self setupUI];
    }
    return self;
}

#pragma mark -
- (void)setupUI{
    //头像
    UIImageView *icon = [[UIImageView alloc] init];
    self.iconImage = icon;
    icon.contentMode = UIViewContentModeCenter;
    icon.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:icon];
    
    //昵称
    UILabel *nick = [[UILabel alloc] init];
    nick.textColor = [UIColor colorWithHexString:@"#333333"];
    nick.font = [UIFont systemFontOfSize:12];
    self.nickLabel = nick;
    [self.contentView addSubview:nick];
    
    //描述
    UILabel *desc = [[UILabel alloc] init];
    desc.textColor = [UIColor colorWithHexString:@"#666666"];
    desc.font = [UIFont systemFontOfSize:11];
    self.descLabel = desc;
    [self.contentView addSubview:desc];
    
    //时间
    UILabel *time = [[UILabel alloc] init];
    time.textColor = [UIColor colorWithHexString:@"#999999"];
    time.font = [UIFont systemFontOfSize:11];
    self.timeLabel = time;
    [self.contentView addSubview:time];
    
    //标题
    UILabel *title = [[UILabel alloc] init];
    title.textColor = [UIColor colorWithHexString:@"#333333"];
    title.font = [UIFont systemFontOfSize:12];
    self.titleLabel = title;
    [self.contentView addSubview:title];
    
    //箭头
    UIImageView *arrow = [[UIImageView alloc] init];
    [self.contentView addSubview:arrow];
    self.arrowImage = arrow;
    arrow.image = [UIImage imageNamed:@"Enter_Arrow"];
    arrow.contentMode = UIViewContentModeCenter;
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-13);
        make.top.equalTo(self.contentView).offset(11);
        make.width.height.equalTo(@20);
    }];
    
    //显示的图片
    UIImageView *image1 = [[UIImageView alloc] init];
    self.picture1 = image1;
    image1.backgroundColor = RandColor;
    [self.contentView addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc] init];
    self.picture2 = image2;
    image2.backgroundColor = RandColor;
    [self.contentView addSubview:image2];
    
    UIImageView *image3 = [[UIImageView alloc] init];
    self.picture3 = image3;
    image3.backgroundColor = RandColor;
    [self.contentView addSubview:image3];
    
    //分割线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#dadada"];
    self.lineView = line;
    [self.contentView addSubview:line];
    
    //点赞
    UIButton *like= [self creatButtonWithTitle:@"20" image:[UIImage imageNamed:@"Like_Default"] selImage:[UIImage imageNamed:@"Like_Selected"] target:self selector:@selector(likeClick:)];
    self.likeBtn = like;
    [self.likeBtn setTitleColor:[UIColor colorWithHexString:@"#d43c33"] forState:UIControlStateSelected];
    like.adjustsImageWhenHighlighted = NO;
    [self.contentView addSubview:like];
    
    //评论
    UIButton *comment = [self creatButtonWithTitle:@"20" image:[UIImage imageNamed:@"Comment"] selImage:[UIImage imageNamed:@"Comment@2x"] target:self selector:@selector(commentClick)];
    self.commentBtn = comment;
    [self.contentView addSubview:comment];
    
}

#pragma mark - private method
//点赞
- (void)likeClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn setTitle:[NSString stringWithFormat:@"%zd",(self.countLike + 1)] forState:UIControlStateSelected];
    }
    if (self.likeBlock) {
        self.likeBlock();
    }
}

//评论
- (void)commentClick{
    if (self.commentBlock) {
        self.commentBlock();
    }
}


#pragma mark - setter and getter
- (void)setOpinionFrame:(GRTheNewestOpinionFrame *)opinionFrame{
    _opinionFrame = opinionFrame;
    
    if (self.opinionFrame.isTotalShow) {
        self.descLabel.numberOfLines = 0;
    }else{
        self.descLabel.numberOfLines = 3;
    }
    //设置内容
    GRTheNewestOpinion *opinionModel = opinionFrame.opinionModel;
//    self.imageView.image = [UIImage imageNamed:discussModel.iconName];
    self.imageView.layer.cornerRadius = 15.5;
    self.imageView.layer.masksToBounds = YES;
    self.nickLabel.text = opinionModel.name;
    self.timeLabel.text = opinionModel.time;
    self.titleLabel.text = opinionModel.title;
    self.descLabel.text = opinionModel.desc;
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%zd",opinionModel.likeCount] forState:UIControlStateNormal];
    
    if (opinionModel.isLiked) {
        self.likeBtn.selected = YES;
        [self.likeBtn setTitle:[NSString stringWithFormat:@"%zd",opinionModel.likeCount] forState:UIControlStateSelected];
    }else{
        self.likeBtn.selected = NO;
        [self.likeBtn setTitle:[NSString stringWithFormat:@"%zd",opinionModel.likeCount] forState:UIControlStateNormal];
    }
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%zd",opinionModel.commentCount] forState:UIControlStateNormal];
    
    //设置 frame
    self.iconImage.frame = opinionFrame.iconFrame;
    self.nickLabel.frame = opinionFrame.nickFrame;
    self.timeLabel.frame = opinionFrame.timeFrame;
    self.titleLabel.frame = opinionFrame.titleFrame;
    self.titleLabel.center = CGPointMake(K_Screen_Width * 0.5, 30);
    self.descLabel.frame = opinionFrame.descFrame;
    self.picture1.frame = opinionFrame.picture1Frame;
    self.picture2.frame = opinionFrame.picture2Frame;
    self.picture3.frame = opinionFrame.picture3Frame;
    self.lineView.frame = opinionFrame.lineFrame;
    self.likeBtn.frame = opinionFrame.likeBtnFrame;
    self.commentBtn.frame = opinionFrame.commentBtnFrame;
}

- (void)setIsShowArrow:(BOOL)isShowArrow{
    _isShowArrow = isShowArrow;
    if (isShowArrow) {
        self.arrowImage.hidden = NO;
    }else{
        self.arrowImage.hidden = YES;
    }
}

#pragma mark - private method
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(GRTheNewestOpinion *)object{
    
    CGFloat statusLabelWidth = [UIScreen mainScreen].bounds.size.width - 26;
    //字符串分类提供方法，计算字符串的高度
    //  ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    CGRect statusLabelRect = [object.desc sizeWithLabelWidth:statusLabelWidth font:[UIFont systemFontOfSize:11]];
    return CGRectGetMaxY(statusLabelRect);
    
}

- (UIButton *)creatButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage target:(id)target selector:(SEL)sel{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:9];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return btn;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRTheNewestOpinionCell";
    GRTheNewestOpinionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRTheNewestOpinionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
