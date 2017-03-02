//
//  GRPersonSettingViewController.m
//  GoldRush
//
//  Created by Jack on 2016/12/31.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "GRPersonSettingViewController.h"
#import "UIImage+GRImage.h"

@interface GRPersonSettingViewController ()<UITableViewDelegate,
                                            UITableViewDataSource,
                                            UIImagePickerControllerDelegate,
                                            UINavigationControllerDelegate>


@property (nonatomic, weak) UITableView *mainTableView;
///数据源数组
@property(nonatomic, strong) NSArray *dataArray;
///头像 View
@property (nonatomic, weak) UIImageView *iconView;
///获取选中的图片
@property (nonatomic, strong) UIImage *selectedImage;


@end

@implementation GRPersonSettingViewController

#pragma mark - life cycle
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound){
        if (self.settingBack) {
            self.settingBack(self.selectedImage);
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //从沙盒拿
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    if (savedImage) {
        self.selectedImage = savedImage;
        [self.mainTableView reloadData];
    }else{
        NSString *url = [GRUserDefault getValueForKey:@"header-icon"];
        self.selectedImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        [self.mainTableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置 UI 和数据
    [self setupUI];
    //初始化 tableview
    [self initTableView];
}

- (void)setupUI{
    self.navigationItem.title = @"个人设置";
    self.dataArray = @[@"昵称",@"账户"];
}

//初始化 tableview
- (void)initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height) style:UITableViewStyleGrouped];
    self.mainTableView = tableView;
    self.mainTableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    [self.mainTableView setSeparatorColor:GRColor(223, 223, 223)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView setSeparatorInset:UIEdgeInsetsZero];
    [self.mainTableView setLayoutMargins:UIEdgeInsetsZero];
    
    [self.view addSubview:self.mainTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"personalSetting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(K_Screen_Width - 53, 10, 40, 40)];
        [cell.contentView addSubview:icon];
        if (_selectedImage) {
            icon.image = _selectedImage;
        }else{
            icon.image = [UIImage imageNamed:@"Header_Icon_Default"];
        }
        icon.layer.cornerRadius = 20;
        icon.layer.masksToBounds = YES;
        self.iconView = icon;
        cell.textLabel.text = @"头像";
    }else{
        cell.textLabel.text = self.dataArray[indexPath.row];
        cell.detailTextLabel.text = [GRUserDefault getUserPhone];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self createActionSheet];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0001;
    }else{
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_Screen_Width, 84)];
        background.backgroundColor = defaultBackGroundColor;
        UIButton *logout = [UIButton buttonWithType:UIButtonTypeCustom];
        [logout setTitle:@"安全退出" forState:UIControlStateNormal];
        [logout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        logout.titleLabel.font = [UIFont systemFontOfSize:18];
        logout.layer.cornerRadius = 5;
        logout.layer.masksToBounds = YES;
        logout.backgroundColor = mainColor;
        [background addSubview:logout];
        [logout mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(background.mas_centerX);
            make.top.equalTo(background.mas_top).offset(40);
            make.left.equalTo(background.mas_left).offset(13);
            make.right.equalTo(background.mas_right).offset(-13);
            make.height.equalTo(@44);
        }];
        [logout addTarget:self action:@selector(logoutClick:) forControlEvents:UIControlEventTouchUpInside];
        return background;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 88;
    }else{
        return 0.0001;
    }
}

#pragma mark - event response
- (void)logoutClick:(UIButton *)btn{
    WS(weakSelf)
    [GRNetWorking postWithURLString:@"?r=member/login/logout" parameters:@{@"r":@"member/login/logout"} callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == 200) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [GRUserDefault removeAllKey];
            //删除本地图片
            [self deleteFile];
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.mainTableView reloadData];
        });
    }];
}

- (void)createActionSheet{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图像" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *openCamera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GRLog(@"打开相机");
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *camera = [[UIImagePickerController alloc] init];
            camera.delegate = self;
            camera.allowsEditing = YES;
            camera.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:camera animated:YES completion:nil];
        }else{
            GRLog(@"相机不可用");
        }
    }];
    [alert addAction:openCamera];
    
    UIAlertAction *openAlbum = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GRLog(@"打开相册");
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *camera = [[UIImagePickerController alloc] init];
            camera.delegate = self;
            camera.allowsEditing = YES;
            camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            camera.navigationBar.barTintColor = GRColor(212.0, 60.0, 51.0);
            camera.navigationBar.translucent = NO;
            [self presentViewController:camera animated:YES completion:nil];
        }else{
            GRLog(@"打不开相册");
        }
    }];
    [alert addAction:openAlbum];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        GRLog(@"取消");
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    GRLog(@"相册回调:%@",info);
    UIImage *originalImage = info[@"UIImagePickerControllerOriginalImage"];
    UIImage *editedImage = info[@"UIImagePickerControllerEditedImage"];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        //写入照片
        UIImageWriteToSavedPhotosAlbum(originalImage, nil, nil, nil);
    }
    self.iconView.image = editedImage;
    self.selectedImage = editedImage;
    
    UIImage *image = [editedImage imageByScalingAndCroppingForSize:CGSizeMake(200, 200)];
    NSString *dataStr = [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *paraDict = @{@"r":@"member/profile/setAvatar",
                               @"avatarData":dataStr};
    [SVProgressHUD show];
    [GRNetWorking postWithURLString:@"?r=member/profile/setAvatar" parameters:paraDict callBack:^(NSDictionary *dict) {
        NSString *code = dict[@"status"];
        if (code.integerValue == HttpSuccess) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showInfoWithStatus:@"头像上传成功!"];
            //应该在提交成功后再保存到沙盒，下次进来直接去沙盒路径取
            //保存图片至本地，方法见下文
            [self saveImage:editedImage withName:@"currentImage.png"];
            //读取路径进行上传
            NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
            UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
            
            [self.iconView setImage:savedImage];//图片赋值显示
        }else{
            [SVProgressHUD showInfoWithStatus:dict[@"message"]];
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 保存图片至沙盒（应该是提交后再保存到沙盒,下次直接去沙盒取）
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName{
    NSData *imageData = UIImagePNGRepresentation(currentImage);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

// 删除沙盒里的文件
- (void)deleteFile {
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"currentImage.png"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        return ;
    }else {
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            GRLog(@"dele success");
        }else {
            GRLog(@"dele fail");
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
