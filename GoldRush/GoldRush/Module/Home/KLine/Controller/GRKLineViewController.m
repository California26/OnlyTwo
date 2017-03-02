//
//  GRKLineViewController.m
//  GoldRush
//
//  Created by Jack on 2016/12/24.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRKLineViewController.h"
/** 滚动文字 */
#import "HeadLine.h"
/** 交易价钱面板 */
#import "GRDealPriceView.h"
#import "GRPriceView.h"
/** 底部面板 */
#import "GRDealFooterView.h"

#import "GRChartHeaderView.h"
#import "GRChart.h"
#import "UIBarButtonItem+GRItem.h"

@interface GRKLineViewController ()<ChartHeaderDelegate,UIGestureRecognizerDelegate>
///背景 View
@property (nonatomic, weak) UIView *topBackgroundView;
///priceBtn
@property (nonatomic, weak) GRPriceView *price;
///轮播文字数组
@property(nonatomic, strong) NSMutableArray *messageArray;
@property (nonatomic,strong) GRChart *chartView;

@property (nonatomic,strong) dispatch_source_t timer;
@property (nonatomic,strong) NSMutableDictionary *dicSource;

@end

@implementation GRKLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    WS(weakself)
    self.view.backgroundColor = [UIColor whiteColor];
    self.dicSource = [NSMutableDictionary dictionary];
    //设置导航栏
    [self setupNavigationBar];
    
    //设置 UI
    [self setupUI];
    
//    NSArray *array = [NSArray arrayWithObjects:@3537,@3593,@3548,@3539,@3544,@3566,@3589,@3577,@3571,@3556,@3553,@3574,@3579,@3581,@3588,@3585,@3580,@3591,@3540, nil];
    
    double delayInSecond = 60;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), (unsigned)(delayInSecond*NSEC_PER_SEC), 0);
    dispatch_source_set_event_handler(_timer, ^{
//        weakself.dicSource = 
    });
    

}

- (void)setupNavigationBar{
    self.navigationItem.title = self.type;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

//设置 UI
- (void)setupUI{
    
    UIView *backgroundView = [[UIView alloc] init];
    self.topBackgroundView = backgroundView;
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self.view);
        make.height.equalTo(@116);
    }];
    backgroundView.backgroundColor = mainColor;
    
    ///创建价格动态按钮
    GRPriceView *price = [[GRPriceView alloc] init];
    self.price = price;
    [backgroundView addSubview:price];
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(backgroundView.mas_top).offset(5);
        make.width.equalTo(@130);
        make.height.equalTo(@80);
    }];
    price.isRise = NO;
    price.price = @"23807";
    //创建跑马灯
    [self createHeadLine];
    
    //创建交易面板价格
    GRDealPriceView *dealView = [[GRDealPriceView alloc] init];
    dealView.maxValue = @"asdf";
    [self.topBackgroundView addSubview:dealView];
    [dealView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topBackgroundView).offset(-13);
        make.bottom.equalTo(self.topBackgroundView).offset(-30);
        make.width.equalTo(@150);
        make.height.equalTo(@80);
    }];
    
    GRDealFooterView *footer = [[GRDealFooterView alloc] init];
    [self.view addSubview:footer];
    [footer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(self.view);
        make.height.equalTo(@85);
    }];
    //K线图的按钮
    GRChartHeaderView *chartHeaderView = [[GRChartHeaderView alloc] initWithFrame:CGRectMake(0, 116, K_Screen_Width, 35)];
    chartHeaderView.delegate = self;
    [self.view addSubview:chartHeaderView];
}

//创建跑马灯
- (void)createHeadLine{
    UIView *view = [[UIView alloc] init];
    [self.topBackgroundView addSubview:view];
    view.layer.cornerRadius = 5.0;
    view.layer.masksToBounds = YES;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.equalTo(@20);
        make.top.equalTo(self.price.mas_bottom).offset(5);
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 20)];
    label.text = @"交易快报";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:11];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHexString:@"#d43c33"];
    
    HeadLine *textView = [[HeadLine alloc]initWithFrame:CGRectMake(80, 0, K_Screen_Width - 120, 20)];
    [textView setBgColor:[UIColor whiteColor] textColor:nil textFont:[UIFont systemFontOfSize:12]];
    [textView setScrollDuration:0.5 stayDuration:3];
    for (int i = 0; i < self.messageArray.count; i ++) {
        NSString *text = self.messageArray[i];
        NSRange range = [text stringSubWithString:@"利" andString:@"元"];
        NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:text];
        [attribut addAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#d43c33"]} range:range];
        [self.messageArray replaceObjectAtIndex:i withObject:attribut];
    }
    textView.messageArray = self.messageArray;
    [textView changeTapMarqueeAction:^(NSInteger index) {
        GRLog(@"你点击了第 %ld 个button！内容：%@", index, textView.messageArray[index]);
    }];
    [textView start];
    [view addSubview:label];
    [view addSubview:textView];
}


#pragma mark - event response
- (void)backClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - setter and getter
- (NSMutableArray *)messageArray{
    if (!_messageArray) {
        _messageArray = [NSMutableArray arrayWithArray:@[@"a150****4567盈利 12323.4元",@"b150****4567盈利 12323.4元",@"c150****4567盈利 12323.4元",@"d150****4567盈利 12323.4元",@"e150****4567盈利 12323.4元"]];
    }
    return _messageArray;
}

#pragma mark chartHeaderDelegate
- (void)buttonAction:(BOOL)chartType
{
    _chartView.timeQuantum = chartType;
}

- (void)buttonDetailImage
{
    
}
@end
