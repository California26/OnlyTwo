//
//  GRDeedBackQuesionViewController.m
//  GoldRush
//
//  Created by Jack on 2016/12/31.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRFeedBackQuesionViewController.h"
#import "UIBarButtonItem+GRItem.h"
#import "UITextView+GRPlaceHolder.h"

@interface GRFeedBackQuesionViewController ()<UITextViewDelegate>

@property (nonatomic, copy) NSString *content;

@end

@implementation GRFeedBackQuesionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];

}

- (void)setupUI{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"提交" target:self action:@selector(handInQuestion)];
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(13, 15, K_Screen_Width - 26, 200)];
    text.placeholder = @"请您填写所要提交的问题!!!";
    text.contentSize = CGSizeZero;
    text.layer.cornerRadius = 5;
    text.layer.masksToBounds = YES;
    text.delegate = self;
    text.backgroundColor = [UIColor colorWithHexString:@"#eff0f2"];
    text.bounces = NO;
    [self.view addSubview:text];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.content = textView.text;
}

#pragma mark - event response
- (void)handInQuestion{
    [self.view endEditing:YES];
    WS(weakSelf)
    //请求提交文字
    NSDictionary *paramDict = @{@"r":@"member/feedback/submit",
                                @"content":self.content};
    [GRNetWorking postWithURLString:@"?r=member/feedback/submit" parameters:paramDict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            [SVProgressHUD showInfoWithStatus:dict[@"recordset"]];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
    }];
    
}

@end
