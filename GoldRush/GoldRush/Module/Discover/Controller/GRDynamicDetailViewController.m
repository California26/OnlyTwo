//
//  GRDynamicDetailViewController.m
//  GoldRush
//
//  Created by Jack on 2017/1/16.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRDynamicDetailViewController.h"
#import "GRDynamicStateCell.h"              //动态 cell
#import "GRDynamicStateCellFrame.h"         //frame 模型
#import "GRDynamicStateModel.h"             //动态数据模型
#import "GRReplyCommentModel.h"             //评论模型数据
#import "GRReplyCommentCellFrame.h"         //评论数据的 frame 模型
#import "GRReplyTimeHeaderView.h"           //头视图
#import "GRTextView.h"                      //输入框
#import "GRKeyBoard.h"                      //键盘监听
#import "GRReplyCommentModel.h"             //评论模型

@interface GRDynamicDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,KeyBoardDlegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) GRTextView *textView;           ///输入框
@property (nonatomic, weak) UIView *backgroundTextView;     ///textview 背景 view

@property (nonatomic, assign) CGFloat keyHeight;            ///键盘高度
@property (nonatomic, assign) CGFloat textHeight;           ///文字高度
@property(nonatomic, strong) NSMutableArray *commentArray;  ///评论数组

@end

@implementation GRDynamicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化tableview
    [self initTableView];
    
    //添加键盘监听和输入框
    [self addKeyBoardAndTextView];
}

- (void)addKeyBoardAndTextView{
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
    
    [GRKeyBoard registerKeyBoardShow:self];
    [GRKeyBoard registerKeyBoardHide:self];
}

- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height - 44) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorColor = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRDynamicStateCell *cell = [GRDynamicStateCell cellWithTableView:tableView];
    cell.cellFrame = self.cellFrame;
    cell.showComment = YES;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellFrame.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
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
        GRReplyCommentModel *model = [[GRReplyCommentModel alloc] init];
        model.time = [NSString stringWithFormat:@"%u:%u",arc4random_uniform(12),arc4random_uniform(60)];
        model.fromName = [NSString stringWithFormat:@"全民:%zd",arc4random_uniform(12)];
        model.desc = textView.text;
        [self.commentArray addObject:model];
        [textView endEditing:YES];
        textView.text = nil;
        textView.placeholder = @"发表你的看法";
        [self.tableView reloadData];
        return NO;
    }
    return YES;
}

#pragma mark - setter and getter
- (NSMutableArray *)commentArray{
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}
@end
