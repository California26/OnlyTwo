//
//  GRContactPopView.m
//  GoldRush
//
//  Created by Jack on 2017/2/20.
//  Copyright © 2017年 Jack. All rights reserved.
//

#import "GRContactPopView.h"
#import "GRContactCell.h"

@interface GRContactPopView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

/// 描述
@property (nonatomic, weak) UILabel *descLabel;
///主 view
@property(nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

///所使用的 webview
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation GRContactPopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCover)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width - 40, 165)];
    self.mainView.center = CGPointMake(K_Screen_Width * 0.5, K_Screen_Height * 0.5);
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.mainView.layer.cornerRadius = 5.0f;
    self.mainView.layer.masksToBounds = YES;
    //边界
    self.mainView.layer.borderColor = [UIColor blackColor].CGColor;
    self.mainView.layer.borderWidth = 1.0;
    [self addSubview:self.mainView];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"请选择联系方式";
    title.textAlignment = NSTextAlignmentCenter;
    [self.mainView addSubview:title];
    title.font = [UIFont systemFontOfSize:21.0];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mainView.mas_centerX);
        make.top.mas_equalTo(self.mainView.mas_top);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mainView addSubview:close];
    [close setImage:[UIImage imageNamed:@"Mine_Contact_Close"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(tapCover) forControlEvents:UIControlEventTouchUpInside];
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(title.mas_centerY);
        make.right.mas_equalTo(self.mainView.mas_right).offset(-10);
    }];
    
    UIView *line = [[UIView alloc] init];
    [self.mainView addSubview:line];
    line.backgroundColor = defaultBackGroundColor;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainView).offset(1);
        make.right.equalTo(self.mainView).offset(-1);
        make.height.mas_equalTo(1);
        make.top.equalTo(title.mas_bottom).offset(-1);
    }];
    
    [self.mainView addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRContactCell *cell = [GRContactCell cellWithTableView:tableView];
    cell.dict = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self jumpQQWithTitle:@"80535636"];
        [self.webView removeFromSuperview];
    }else{
        [self callPhone:@"15031599217"];
        [self.webView removeFromSuperview];
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

- (void)jumpQQWithTitle:(NSString *)qqNum{
    NSString *qqstr = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqNum];
    NSURL *url = [NSURL URLWithString:qqstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self addSubview:self.webView];
}

//拨打电话
- (void)callPhone:(NSString *)phoneNumber{
    //phoneNumber = "18369......"
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self addSubview:self.webView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, K_Screen_Width - 40, 120) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource  = self;
        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

- (void)tapCover{
    [self removeFromSuperview];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@{@"icon":@"Mine_Online_Service",@"title":@"在线客服",@"desc":@"QQ在线服务(09:00-18:00)"},@{@"icon":@"Mine_Contact_Phone",@"title":@"拨打客服电话",@"desc":@"12312312(09:00-20:00)"}, nil];
    }
    return _dataArray;
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _webView;
}

@end
