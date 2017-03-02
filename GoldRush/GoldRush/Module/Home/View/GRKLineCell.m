//
//  GRKLineCell.m
//  GoldRush
//
//  Created by Jack on 2016/12/23.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRKLineCell.h"
#import "GRRiseButton.h"

#define buttonWidth ((K_Screen_Width - 6)/ 3)
#define buttonHeight 90

@interface GRKLineCell ()<UIScrollViewDelegate>

@property(nonatomic, strong) NSMutableArray <NSString *>*textArray; ///按钮文字数组
@property(nonatomic, strong) UIButton *selectedBtn;                 ///被选中的按钮
@property(nonatomic, weak) UIScrollView *buttonScrollView;         ///放置按钮的 view
@property(nonatomic, strong) UIPageControl *pageControl;            ///pageControl
@property(nonatomic, assign) NSInteger currIndex;                  ///当前显示图片的索引

@end

@implementation GRKLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textArray = [NSMutableArray arrayWithArray:@[@"恒大银",@"吉微铜",@"吉微油",@"吉微银"]];
        //添加子控件
        [self setupChildView];
        //添加 pageControl
        [self addPageControl];
    }
    return self;
}

//添加子控件
- (void)setupChildView{
    UIScrollView *buttonView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 90)];
    self.buttonScrollView = buttonView;
    buttonView.delegate = self;
    buttonView.bounces = NO;
    buttonView.pagingEnabled = YES;
    for (int i = 0; i < 4; i ++) {
        GRRiseButton *button = [GRRiseButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.textArray[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(i * (buttonWidth + 3), 0, buttonWidth, buttonHeight);
        [buttonView addSubview:button];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.isShowClose = NO;
        button.colorType = PriceLabelColorGreen;
        button.tag = 9876 + i;
        [button setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        if (0 == i) {
            [self btnClick:button];
        }
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame) + 1, 10, 1, buttonHeight - 10)];
        [buttonView addSubview:view];
        view.backgroundColor = GRColor(205, 205, 205);
        view.tag = 6789 + i;
    }
    buttonView.contentSize = CGSizeMake(buttonWidth * self.textArray.count + 9, 43);
    buttonView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:buttonView];
}

- (void)flashWithTag:(GRRiseButton *)button{
    if (CGColorEqualToColor(button.backgroundColor.CGColor, [UIColor colorWithHexString:@"#feecf0"].CGColor)) {
        button.backgroundColor = [UIColor whiteColor];
    }else{
        button.backgroundColor = [UIColor colorWithHexString:@"#feecf0"];
    }
}

/**
 添加 pageControl
 */
- (void)addPageControl{
    UIPageControl *page = [[UIPageControl alloc] init];
    [self.contentView addSubview:page];
    [page mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.buttonScrollView);
        make.height.mas_equalTo(10);
        make.width.equalTo(self.buttonScrollView.mas_width);
        make.top.equalTo(self.buttonScrollView.mas_bottom).offset(5);
    }];
    self.pageControl = page;
    page.enabled = NO;
    page.pageIndicatorTintColor = [UIColor colorWithHexString:@"#cccccc"];
    page.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#999999"];
    page.numberOfPages = 2;
    page.currentPage = self.currIndex;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 记录scrollView 的当前位置，因为已经设置了分页效果，所以：位置/屏幕大小 = 第几页
    self.currIndex = scrollView.contentOffset.x / buttonWidth;
    //根据scrollView 的位置对page 的当前页赋值
    self.pageControl.currentPage = self.currIndex;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x < buttonWidth) {
        UIView *view = [self.buttonScrollView viewWithTag:6789];
        view.alpha = 1.0;
    }else{
        UIView *view = [self.buttonScrollView viewWithTag:6789];
        view.alpha = 0.0;
    }
}

#pragma mark - event response
- (void)btnClick:(UIButton *)btn{
    //切换按钮点击状态
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;

    if (self.btnClick) {
        self.btnClick(btn.tag - 9876);
    }
}

#pragma mark - setter and getter
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    for (int i = 0; i < dataArray.count; i ++) {
        GRRiseButton *btn = [self.contentView viewWithTag:9876 + i];
        btn.priceDict = dataArray[i];
        
        NSNumber *price = dataArray[i][@"theNewestPrice"];
        if ([price isEqualToNumber:@(0)]) {
            btn.isShowClose = YES;
            btn.colorType = PriceLabelColorGray;
            [btn setTitleColor:[UIColor colorWithHexString:@"#dcdada"] forState:UIControlStateSelected];
        }else{
            btn.isShowClose = NO;
            btn.colorType = PriceLabelColorRed;
        }
        
        NSString *profitAndLoss = dataArray[i][@"profitAndLoss"];
        if (profitAndLoss.floatValue >= 0) {
            btn.colorType = PriceLabelColorRed;
            btn.shimmerColor = [UIColor colorWithHexString:@"#feecf0"];
        }else{
            btn.colorType = PriceLabelColorGreen;
            btn.shimmerColor = [UIColor colorWithHexString:@"#e6faf0"];
        }
        NSString *change = dataArray[i][@"isChange"];
        BOOL isChange = change.boolValue;
        if (isChange) {
            GRLog(@"闪烁按钮 tag %ld",btn.tag - 9876);
            [btn startShimmer];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [btn stopShimmer];
            });
        }
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"KLine";
    GRKLineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRKLineCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
