//
//  GRHotDiscussCell.m
//  GoldRush
//
//  Created by Jack on 2016/12/24.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRHotDiscussCell.h"
#import "GRDiscussModel.h"
#import "GRDiscusscellFrame.h"
#import "UIView+GRExtension.h"

@interface GRHotDiscussCell ()

/// 头像
@property (weak, nonatomic)  UIImageView *iconImage;
/// 昵称
@property (weak, nonatomic)  UILabel *nickLabel;
/// 描述
@property (weak, nonatomic)  UILabel *descLabel;
/// 时间
@property (weak, nonatomic)  UILabel *timeLabel;
/// 手机型号
@property (weak, nonatomic)  UILabel *phoneLabel;
///分割线
@property (nonatomic, weak) UIView *lineView;
/// 评论
@property (weak, nonatomic)  UIButton *commentBtn;
/// 点赞
@property (weak, nonatomic)  UIButton *likeBtn;

///显示的图片
@property (nonatomic, weak) UIImageView *picture1;
@property (nonatomic, weak) UIImageView *picture2;
@property (nonatomic, weak) UIImageView *picture3;

///点赞数
@property (nonatomic, assign) NSInteger countLike;


@end

@implementation GRHotDiscussCell

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
    nick.textColor = [UIColor colorWithHexString:@"#666666"];
    nick.font = [UIFont systemFontOfSize:12];
    self.nickLabel = nick;
    [self.contentView addSubview:nick];
    
    //描述
    UILabel *desc = [[UILabel alloc] init];
    desc.textColor = [UIColor colorWithHexString:@"#999999"];
    desc.font = [UIFont systemFontOfSize:11];
    desc.numberOfLines = 3;
    self.descLabel = desc;
    [self.contentView addSubview:desc];
    
    //时间
    UILabel *time = [[UILabel alloc] init];
    time.textColor = [UIColor colorWithHexString:@"#666666"];
    time.font = [UIFont systemFontOfSize:10];
    self.timeLabel = time;
    [self.contentView addSubview:time];
    
    //手机型号
    UILabel *phone = [[UILabel alloc] init];
    phone.textColor = [UIColor colorWithHexString:@"#666666"];
    phone.font = [UIFont systemFontOfSize:8];
    self.phoneLabel = phone;
    [self.contentView addSubview:phone];
    
    //显示的图片
    UIImageView *image1 = [[UIImageView alloc] init];
    self.picture1 = image1;
    image1.backgroundColor = RandColor;
    [self.contentView addSubview:image1];
    image1.contentMode = UIViewContentModeScaleAspectFill;
    image1.layer.masksToBounds = YES;
    
    UIImageView *image2 = [[UIImageView alloc] init];
    self.picture2 = image2;
    image2.backgroundColor = RandColor;
    [self.contentView addSubview:image2];
    image2.contentMode = UIViewContentModeScaleAspectFill;
    image2.layer.masksToBounds = YES;
    
    UIImageView *image3 = [[UIImageView alloc] init];
    self.picture3 = image3;
    image3.backgroundColor = RandColor;
    [self.contentView addSubview:image3];
    image3.contentMode = UIViewContentModeScaleAspectFill;
    image3.layer.masksToBounds = YES;
    
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
- (void)setDiscussFrame:(GRDiscusscellFrame *)discussFrame{
    _discussFrame = discussFrame;
    
    //设置内容
    GRDiscussModel *discussModel = discussFrame.discussModel;
    self.iconImage.image = [UIImage imageNamed:discussModel.iconName];
    self.iconImage.layer.cornerRadius = 15.5;
    self.iconImage.layer.masksToBounds = YES;
    self.nickLabel.text = discussModel.name;
    self.timeLabel.text = discussModel.time;
    self.phoneLabel.text = discussModel.phone;
    self.descLabel.text = discussModel.msgContent;
    
    if (discussModel.picNamesArray.count == 1) {
        self.picture1.image = [UIImage imageNamed:discussModel.picNamesArray[0]];
    }else if (discussModel.picNamesArray.count == 2){
        self.picture1.image = [UIImage imageNamed:discussModel.picNamesArray[0]];
        self.picture2.image = [UIImage imageNamed:discussModel.picNamesArray[1]];
    }else if(discussModel.picNamesArray.count == 3){
        self.picture1.image = [UIImage imageNamed:discussModel.picNamesArray[0]];
        self.picture2.image = [UIImage imageNamed:discussModel.picNamesArray[1]];
        self.picture3.image = [UIImage imageNamed:discussModel.picNamesArray[2]];
    }else{
        
    }
    
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%zd",discussModel.likeCount] forState:UIControlStateNormal];
    
    if (discussModel.isLiked) {
        self.likeBtn.selected = YES;
        [self.likeBtn setTitle:[NSString stringWithFormat:@"%zd",discussModel.likeCount] forState:UIControlStateSelected];
    }else{
        self.likeBtn.selected = NO;
        [self.likeBtn setTitle:[NSString stringWithFormat:@"%zd",discussModel.likeCount] forState:UIControlStateNormal];
    }
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%zd",discussModel.commentCount] forState:UIControlStateNormal];
    
    //设置 frame
    self.iconImage.frame = discussFrame.iconFrame;
    self.nickLabel.frame = discussFrame.nickFrame;
    self.timeLabel.frame = discussFrame.timeFrame;
    self.phoneLabel.frame = discussFrame.phoneFrame;
    self.descLabel.frame = discussFrame.descFrame;
    
    self.picture1.frame = discussFrame.picture1Frame;
    self.picture2.frame = discussFrame.picture2Frame;
    self.picture3.frame = discussFrame.picture3Frame;
    
    self.lineView.frame = discussFrame.lineFrame;
    self.likeBtn.frame = discussFrame.likeBtnFrame;
    self.commentBtn.frame = discussFrame.commentBtnFrame;
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
    static NSString *cellID = @"GRHotDiscussCell";
    GRHotDiscussCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRHotDiscussCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
