//
//  GRDynamicStateCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/14.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRDynamicStateCell.h"
#import "GRDynamicStateModel.h"             ///动态的数据模型
#import "GRDynamicStateCellFrame.h"         ///动态的 frame 模型

/** 评论区域的文件 */
#import "GRAttributedLabel.h"               ///属性 label
#import "GRReplyCommentCell.h"              ///评论回复cell
#import "GRReplyCommentCellFrame.h"         ///评论的 cell 的 frame 模型

@interface GRDynamicStateCell ()<UITableViewDelegate,UITableViewDataSource,GRReplyCommentCellDelegate>

@property (nonatomic, weak) UIImageView *iconImageView;         ///头像
@property (nonatomic, weak) UILabel *nickLabel;                 ///昵称
@property (nonatomic, weak) UILabel *descLabel;                 ///详情
@property (nonatomic, weak) UILabel *timeLabel;                 ///时间
@property (nonatomic, weak) UILabel *phoneLabel;                ///手机型号
@property (nonatomic, weak) UIView *lineView;                   ///分割线
@property (weak, nonatomic) UIButton *commentBtn;               /// 评论
@property (weak, nonatomic) UIButton *likeBtn;                  /// 点赞
@property (nonatomic, weak) UIImageView *picture1;              ///显示的图片
@property (nonatomic, weak) UIImageView *picture2;
@property (nonatomic, weak) UIImageView *picture3;
@property (nonatomic, assign) NSInteger countLike;              ///点赞数
@property (nonatomic, weak) UIView *grayView;                   ///灰色条

/** 评论区域的控件 */
@property (nonatomic, strong) UITableView *commentTableView;      ///tableView
//@property (nonatomic, strong) GRAttributedLabel *nameLabel;     ///用户名字 label
//@property (nonatomic, strong) GRAttributedLabel *topicLabel;    ///主题 label


@end

@implementation GRDynamicStateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //创建头部
        [self createHeaderView];
        
        //创建图片和下部评论按钮
        [self createPictureAndComment];
        
    }
    return self;
}

- (void)createHeaderView{
    
    //头像
    UIImageView *icon = [[UIImageView alloc] init];
    self.iconImageView = icon;
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
}

- (void)createPictureAndComment{
    
    //显示的图片
    UIImageView *image1 = [[UIImageView alloc] init];
    self.picture1 = image1;
    image1.backgroundColor = RandColor;
    [self.contentView addSubview:image1];
    image1.contentMode = UIViewContentModeScaleAspectFill;
    image1.layer.masksToBounds = YES;
    image1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPicture:)];
    [image1 addGestureRecognizer:tap1];
    
    UIImageView *image2 = [[UIImageView alloc] init];
    self.picture2 = image2;
    image2.backgroundColor = RandColor;
    [self.contentView addSubview:image2];
    image2.contentMode = UIViewContentModeScaleAspectFill;
    image2.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPicture:)];
    [image2 addGestureRecognizer:tap2];
    
    UIImageView *image3 = [[UIImageView alloc] init];
    self.picture3 = image3;
    image3.backgroundColor = RandColor;
    [self.contentView addSubview:image3];
    image3.contentMode = UIViewContentModeScaleAspectFill;
    image3.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPicture:)];
    [image3 addGestureRecognizer:tap3];
    
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
    
    //灰色条
    UIView *height = [[UIView alloc] init];
    [self.contentView addSubview:height];
    height.backgroundColor = GRColor(240, 240, 240);
    self.grayView = height;
}

#pragma mark - event response
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

//点击图片
- (void)tapPicture:(UITapGestureRecognizer *)tap{
    // 让图片填充 self.view
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGFloat screenW = CGRectGetWidth(bounds);
    CGFloat screenH = CGRectGetHeight(bounds);
    CGFloat imageW = CGRectGetWidth(self.imageView.frame);
    CGFloat imageH = CGRectGetHeight(self.imageView.frame);
    
    CGFloat sx = screenW / imageW;
    CGFloat sy = (screenH - 64) / imageH;
    
    CGFloat tx = self.contentView.center.x - self.imageView.center.x;
    CGFloat ty = (screenH - 64) * 0.5 - CGRectGetMinY(self.imageView.frame);
    
    [UIView animateWithDuration:0.25f animations:^{
        CGAffineTransform transform = CGAffineTransformMake(sx, 0, 0, sy, tx, ty);
        self.imageView.transform = transform;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - private method
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
    static NSString *cellID = @"GRDynamicStateCell";
    GRDynamicStateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRDynamicStateCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - setter and getter
- (void)setCellFrame:(GRDynamicStateCellFrame *)cellFrame{
    _cellFrame = cellFrame;
    
    //设置内容
    GRDynamicStateModel *dynamicModel = cellFrame.dynamicModel;
    self.iconImageView.image = [UIImage imageNamed:dynamicModel.iconName];
    self.iconImageView.layer.cornerRadius = 15.5;
    self.iconImageView.layer.masksToBounds = YES;
    self.nickLabel.text = dynamicModel.name;
    self.timeLabel.text = dynamicModel.time;
    self.phoneLabel.text = dynamicModel.phone;
    self.descLabel.text = dynamicModel.msgContent;
    
    if (dynamicModel.picNamesArray.count == 1) {
        self.picture1.image = [UIImage imageNamed:dynamicModel.picNamesArray[0]];
    }else if (dynamicModel.picNamesArray.count == 2){
        self.picture1.image = [UIImage imageNamed:dynamicModel.picNamesArray[0]];
        self.picture2.image = [UIImage imageNamed:dynamicModel.picNamesArray[1]];
    }else if(dynamicModel.picNamesArray.count == 3){
        self.picture1.image = [UIImage imageNamed:dynamicModel.picNamesArray[0]];
        self.picture2.image = [UIImage imageNamed:dynamicModel.picNamesArray[1]];
        self.picture3.image = [UIImage imageNamed:dynamicModel.picNamesArray[2]];
    }
    
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%zd",dynamicModel.likeCount] forState:UIControlStateNormal];
    
    if (dynamicModel.isLiked) {
        self.likeBtn.selected = YES;
        [self.likeBtn setTitle:[NSString stringWithFormat:@"%zd",dynamicModel.likeCount] forState:UIControlStateSelected];
    }else{
        self.likeBtn.selected = NO;
        [self.likeBtn setTitle:[NSString stringWithFormat:@"%zd",dynamicModel.likeCount] forState:UIControlStateNormal];
    }
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%zd",dynamicModel.commentCount] forState:UIControlStateNormal];
    
    //设置 frame
    self.iconImageView.frame = cellFrame.iconFrame;
    self.nickLabel.frame = cellFrame.nickFrame;
    self.timeLabel.frame = cellFrame.timeFrame;
    self.phoneLabel.frame = cellFrame.phoneFrame;
    self.descLabel.frame = cellFrame.descFrame;
    
    self.picture1.frame = cellFrame.picture1Frame;
    self.picture2.frame = cellFrame.picture2Frame;
    self.picture3.frame = cellFrame.picture3Frame;
    
    self.lineView.frame = cellFrame.lineFrame;
    self.likeBtn.frame = cellFrame.likeBtnFrame;
    self.commentBtn.frame = cellFrame.commentBtnFrame;
    self.grayView.frame = CGRectMake(0, CGRectGetMaxY(cellFrame.commentBtnFrame), K_Screen_Width, 10);
    
    self.commentTableView.frame = cellFrame.tableViewFrame;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellFrame.commentCellFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRReplyCommentCell *cell = [GRReplyCommentCell cellWithTableView:tableView];
    cell.replyModelFrame = self.cellFrame.commentCellFrame[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRReplyCommentCellFrame *frame = self.cellFrame.commentCellFrame[indexPath.row];
    return frame.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:didReplyClicked:)]) {
        [self.delegate cell:self didReplyClicked:((GRReplyCommentCellFrame *)self.cellFrame.commentCellFrame[indexPath.row]).commentModel];
    }
}

#pragma mark - GRReplyCommentCellDelegate
- (void)cell:(GRReplyCommentCell *)cell didUserInfoClicked:(NSString *)username{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:didUserClicked:)]) {
        [self.delegate cell:self didUserClicked:username];
    }
}

#pragma mark - setter and getter
- (UITableView *)commentTableView{
    if (!_commentTableView) {
        _commentTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _commentTableView.delegate = self;
        _commentTableView.dataSource = self;
        _commentTableView.bounces = NO;
        _commentTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _commentTableView.backgroundColor = [UIColor blueColor];
    }
    return _commentTableView;
}

- (void)setShowComment:(BOOL)showComment{
    _showComment = showComment;
    
    if (showComment) {
        [self.contentView addSubview:self.commentTableView];
    }else{
        [self.commentTableView removeFromSuperview];
    }
}

@end
