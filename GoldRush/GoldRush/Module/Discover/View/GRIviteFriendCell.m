//
//  GRIviteFriendCell.m
//  GoldRush
//
//  Created by Jack on 2017/1/12.
//  Copyright © 2017年 Jack. All rights reserved.
//

#define btnWidth (K_Screen_Width / 3)
static CGFloat const btnheight = 94;

#import "GRIviteFriendCell.h"
#import "UIButton+GRButtonLayout.h"

@interface GRIviteFriendCell ()

///按钮文字
@property(nonatomic, strong) NSMutableArray <NSString *>*textArray;
///按钮图片
@property(nonatomic, strong) NSMutableArray <NSString *>*imageArray;

@end

@implementation GRIviteFriendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = GRColor(240, 240, 240);
        //设置子控件
        [self setupChildView];
        
    }
    return self;
}

- (void)setupChildView{
    for (int i = 0; i < self.textArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.textArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = [UIColor whiteColor];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        if (iPhone5) {
            btn.titleRect = CGRectMake(25, 65, btnWidth, 30);
            btn.imageRect = CGRectMake(0, 5, btnWidth, btnheight - 30);
        }else if (iPhone6){
            btn.titleRect = CGRectMake(32, 65, btnWidth, 30);
            btn.imageRect = CGRectMake(0, 5, btnWidth, btnheight - 30);
        } else{
            btn.titleRect = CGRectMake(40, 65, btnWidth, 30);
            btn.imageRect = CGRectMake(0, 5, btnWidth, btnheight - 30);
        }
        [btn setImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(btnWidth * i, 10, btnWidth, btnheight);
        [btn addTarget:self action:@selector(newHandClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

#pragma mark - event response
- (void)newHandClick:(UIButton *)btn{
    
}

#pragma mark - setter and getter
- (NSMutableArray *)textArray{
    if (!_textArray) {
        _textArray = [NSMutableArray arrayWithArray:@[@"邀请好友",@"盈利排行",@"全民学堂"]];
    }
    return _textArray;
}
- (NSMutableArray<NSString *> *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithArray:@[@"Discover_Ivite_Friend",@"Discover_Cup",@"Discover_Book"]];
    }
    return _imageArray;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"GRIviteFriendCell";
    GRIviteFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GRIviteFriendCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
