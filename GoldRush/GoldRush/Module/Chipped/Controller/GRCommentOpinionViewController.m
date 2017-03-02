//
//  GRCommentOpinionViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/7.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRCommentOpinionViewController.h"
#import "GRTheNewestOpinionCell.h"      ///最新观点 cell
#import "GRTheNewestOpinionFrame.h"     ///最新观点frame模型
#import "GRTheNewestOpinion.h"          ///最新观点数据模型
#import "GRTextView.h"                  ///自定义 textview
#import "GRKeyBoard.h"                  ///键盘监听
#import "GRAnalystCommentCell.h"        ///分析师评论的 cell
#import "GRAnalystComment.h"            ///评论的数据模型

@interface GRCommentOpinionViewController ()<UITableViewDelegate,UITableViewDataSource,KeyBoardDlegate,UITextViewDelegate>

@property (nonatomic, weak) UITableView *mainTableView;

@property(nonatomic, strong) NSMutableArray *dataArray;     ///数据源数组
@property (nonatomic, weak) UIView *backgroundTextView;     ///textview 背景 view

@property (nonatomic, assign) CGFloat keyHeight;            ///键盘高度
@property (nonatomic, assign) CGFloat textHeight;           ///文字高度
@property(nonatomic, strong) NSMutableArray *commentArray;  ///评论数组

@property (nonatomic, weak) GRTextView *textView;           ///输入框


@end

@implementation GRCommentOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    
    //模拟数据
    NSArray *array = [self creatModelsWithCount:1];
    for (GRTheNewestOpinion *model  in array) {
        GRTheNewestOpinionFrame *frameModel = [[GRTheNewestOpinionFrame alloc] init];
        frameModel.isTotalShow = YES;
        frameModel.opinionModel = model;
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:frameModel];
        [self.dataArray addObject:array];
    }

    [GRKeyBoard registerKeyBoardShow:self];
    [GRKeyBoard registerKeyBoardHide:self];
}


- (NSArray *)creatModelsWithCount:(NSInteger)count{
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"OneWang_iOS",
                            @"风芊语芊寻上的猪",
                            @"芊语芊寻",
                            @"我叫芊语芊寻",
                            @"Hel芊语芊寻tty"];
    
    NSArray *time = @[@"12:30",@"4:350",@"6:30",@"8:30",@"9:30",@"3:30",@"2:37",@"2:39"];
    
    NSArray *phone = @[@"白银多头梦碎",@"要长期出差两",@"要长期出差两",@"不要长期处于这种",@"于这种模式"];
    
    NSArray *textArray = @[@"作为应届毕业生的我和老板mage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期出差两天，学到了这些大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任芊语芊度返回 320这种模式下对界面不会产寻把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 32拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
                           @"但是建议不要长期处于这种模式mage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 32比例拉伸到mage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    
    NSArray *picImageNamesArray = @[ @"0.jpg",
                                     @"1.jpg",
                                     @"2.jpg",
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        int timeRandomIndex = arc4random_uniform(8);
        int phoneRandomIndex = arc4random_uniform(5);
        
        GRTheNewestOpinion *model = [GRTheNewestOpinion new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.desc = textArray[contentRandomIndex];
        model.time = time[timeRandomIndex];
        model.title = phone[phoneRandomIndex];
        
        // 模拟“随机图片”
        int random = arc4random_uniform(3);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(3);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        [resArr addObject:model];
    }
    return [resArr copy];
}

//初始化 tableview
- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 44) style:UITableViewStyleGrouped];
    self.mainTableView = tableView;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, K_Screen_Height - 44, K_Screen_Width, 44)];
    background.backgroundColor = [UIColor whiteColor];
    self.backgroundTextView = background;
    
    GRTextView *textView = [[GRTextView alloc] initWithFrame:CGRectMake(13, 6, K_Screen_Width - 26, 32)];
    textView.font = [UIFont systemFontOfSize:12];
    self.textView = textView;
    textView.cornerRadius = 4;
    textView.delegate = self;
    textView.returnKeyType = UIReturnKeySend;
    textView.backgroundColor = [UIColor colorWithHexString:@"#eff0f2"];
    textView.placeholder = @"发表你的看法";
    textView.placeholderFont = [UIFont systemFontOfSize:12];
    textView.placeholderColor = [UIColor colorWithHexString:@"#666666"];
    [textView textValueDidChanged:^(NSString *text, CGFloat textHeight) {
        CGRect textFrame = textView.frame;
        textFrame.size.height = textHeight;
        textView.frame = textFrame;
        
        CGRect backgroundFrame = background.frame;
        backgroundFrame.size.height = textHeight + 12;
        backgroundFrame.origin.y = K_Screen_Height - 44 - textHeight + 31 - self.keyHeight;
        self.textHeight = textHeight;
        background.frame = backgroundFrame;
    }];
    textView.maxNumberOfLines = 5;
    
    [background addSubview:textView];
    [self.view addSubview:background];
//    [self.view bringSubviewToFront:background];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        NSMutableArray *array = self.dataArray[section];
        return array.count;
    }else{
        return self.commentArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GRTheNewestOpinionCell *cell = [GRTheNewestOpinionCell cellWithTableView:tableView];
        NSMutableArray *array = self.dataArray[indexPath.section];
        GRTheNewestOpinionFrame *frame = array[indexPath.row];
        if (self.commentArray.count) {
            frame.opinionModel.commentCount ++;
        }
        cell.isShowArrow = NO;
        cell.opinionFrame = frame;
        return cell;
    }else{
        GRAnalystCommentCell *cell = [GRAnalystCommentCell cellWithTableView:tableView];
        WS(weakSelf)
        cell.tapDescLabel = ^{
            weakSelf.textView.placeholder = @"回复全民123444";
            [weakSelf.textView becomeFirstResponder];
        };
        cell.commentModel = self.commentArray[indexPath.row];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSMutableArray *array = self.dataArray[indexPath.section];
        GRTheNewestOpinionFrame *frame = array[indexPath.row];
        return frame.rowHeight;
    }else{
        if (self.commentArray) {
            return [GRAnalystCommentCell tableView:tableView rowHeightForObject:self.commentArray[indexPath.row]];
        }else{
            return 0.0001;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

#pragma mark - KeyBoardDlegate

- (void)keyboardWillShowNotification:(NSNotification *)notification{
    CGRect keyboardEndFrameWindow = [GRKeyBoard returnKeyBoardWindow:notification];
    double keyboardTransitionDuration = [GRKeyBoard returnKeyBoardDuration:notification];
    UIViewAnimationCurve keyboardTransitionAnimationCurve = [GRKeyBoard returnKeyBoardAnimationCurve:notification];
    [UIView animateWithDuration:keyboardTransitionDuration delay:0 options:(UIViewAnimationOptions)keyboardTransitionAnimationCurve << 16 animations:^{
        CGFloat y = K_Screen_Height - 44;
        CGRect frame = CGRectMake(0, y, K_Screen_Width, 44);
        self.keyHeight = keyboardEndFrameWindow.size.height;
        if (self.textHeight) {
            frame.origin.y -= keyboardEndFrameWindow.size.height + self.textHeight - 31;
            frame.size.height = 44 + self.textHeight - 31;
        }else{
            frame.origin.y -= keyboardEndFrameWindow.size.height;
        }
        self.backgroundTextView.frame = frame;
    } completion:nil];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification{
    CGRect keyboardEndFrameWindow = [GRKeyBoard returnKeyBoardWindow:notification];
    double keyboardTransitionDuration = [GRKeyBoard returnKeyBoardDuration:notification];
    UIViewAnimationCurve keyboardTransitionAnimationCurve = [GRKeyBoard returnKeyBoardAnimationCurve:notification];
    [UIView animateWithDuration:keyboardTransitionDuration delay:0 options:(UIViewAnimationOptions)keyboardTransitionAnimationCurve << 16 animations:^{
        CGPoint center = self.backgroundTextView.center;
        center.y += keyboardEndFrameWindow.size.height;
        self.keyHeight = keyboardEndFrameWindow.size.height;
        self.backgroundTextView.center = center;
    } completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(GRTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        //点击 send 按钮发送评论
        GRAnalystComment *model = [[GRAnalystComment alloc] init];
        model.time = [NSString stringWithFormat:@"%u:%u",arc4random_uniform(12),arc4random_uniform(60)];
        model.name = [NSString stringWithFormat:@"全民:%zd",arc4random_uniform(12)];
        model.desc = textView.text;
        [self.commentArray addObject:model];
        [textView endEditing:YES];
        textView.text = nil;
        textView.placeholder = @"发表你的看法";
        [self.mainTableView reloadData];
        return NO;
    }
    return YES;
}

#pragma mark setter and getter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)commentArray{
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
