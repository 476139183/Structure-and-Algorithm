//
//  EditViewController.m
//  云屏
//
//  Created by LDY on 14-7-30.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "EditViewController.h"
#import "ASIFormDataRequest.h"
#import "NSString+SBJSON.h"
#import "SGInfoAlert.h"
#import "Config.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    DLog(@"\nself.view.frame.size.width = %f\nself.view.frame.size.height = %f",self.view.frame.size.width, self.view.frame.size.height);
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"baocun", @"保存") style:UIBarButtonItemStylePlain target:self action:@selector(updateInfomation)];
    editTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, 540, 620) style:UITableViewStyleGrouped];
    editTableView.delegate = self;
    editTableView.dataSource = self;
    [self.view addSubview:editTableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(tapHeadImage)];
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 100, 100)];
    headImageView.image = self.headImage;
    headImageView.userInteractionEnabled = YES;
    [headImageView addGestureRecognizer:tap];
    
    editName = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 520, 40)];
    editName.text = self.nameString;
    
    editTel = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 520, 40)];
    editTel.text = self.telString;
    editTel.delegate = self;
    
    editQQ = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 520, 40)];
    editQQ.text = self.qqString;
    editQQ.delegate = self;
    
    editDescription = [[UITextView alloc] initWithFrame:CGRectMake(20, 0, 520, 160)];
    editDescription.scrollEnabled = YES;
    editDescription.text = self.descriptionString;
    editDescription.delegate = self;
    editDescription.backgroundColor = [UIColor clearColor];
    if (!DEVICE_IS_IPAD) {
        editTableView.frame = CGRectMake(0, 10, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - 50 - 10);
        editName.frame = CGRectMake(20, 0, SCREEN_CGSIZE_WIDTH, 40);
        editTel.frame = CGRectMake(20, 0, SCREEN_CGSIZE_WIDTH, 40);
        editQQ.frame = CGRectMake(20, 0, SCREEN_CGSIZE_WIDTH, 40);
        editDescription.frame = CGRectMake(20, 0, SCREEN_CGSIZE_WIDTH, 160);
    }
}

//点击头像
- (void)tapHeadImage
{
    DLog(@"点击了头像");
    
    if (OS_VERSION_FLOAT >= 8.0) {
//        return;
    }
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"NSString16", @"") delegate:self cancelButtonTitle:nil destructiveButtonTitle:NSLocalizedString(@"NSString17", @"") otherButtonTitles:NSLocalizedString(@"NSString19", @""),NSLocalizedString(@"NSString18", @""), nil];//@"选择" @"取消" @"拍照" @"从相册选择"
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"NSString16", @"") delegate:self cancelButtonTitle:nil destructiveButtonTitle:NSLocalizedString(@"NSString17", @"") otherButtonTitles:NSLocalizedString(@"NSString19", @""), nil];//@"选择" @"取消"  @"从相册选择"
    }
    
    sheet.tag = 255;
    
//    sheet  = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"NSString16", @"") delegate:self cancelButtonTitle:nil destructiveButtonTitle:NSLocalizedString(@"NSString17", @"") otherButtonTitles:NSLocalizedString(@"NSString18", @""), nil];//@"选择" @"取消" @"拍照" @"从相册选择"
    
    [sheet showInView:self.view];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSInteger sourceType = UIImagePickerControllerSourceTypeCamera;
    if (buttonIndex == 0) {
        return;
    }
    else if (buttonIndex == 1)
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.modalPresentationStyle = UIModalPresentationCustom;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        
        if (DEVICE_IS_IPAD) {
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
            popover.delegate = self;
            [popover presentPopoverFromRect:CGRectMake(0, 100, 115, 70) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        }else {
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }
    else if (buttonIndex == 2) {
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        imagePickerController.modalPresentationStyle = UIModalPresentationCustom;
        [self.navigationController presentViewController:imagePickerController animated:YES completion:^{}];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    ;
    DLog(@"%@",info);
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
    }];
    headImageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
    }];
}
#pragma mark - UIPopoverControllerDelegate
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
}

//返回按钮
- (void)back
{
    if (DEVICE_IS_IPAD) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.navigationController.view removeFromSuperview];
        self.navigationController.navigationBar.hidden = YES;
    }
}
- (void)updateInfomation
{
    DLog(@"更新信息");
    if ([editTel.text length]!=11) {
        [SGInfoAlert showInfo:NSLocalizedString(@"NSStringphoneLengthError",@"电话号码长度不正确")
                      bgColor:[[UIColor darkGrayColor] CGColor]
                       inView:self.view
                     vertical:0.4];
        return;
    }

    
    [self saveImage:headImageView.image withName:@"currentImage.png"];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSURL *editUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?key=%@",URL_UPDATE_USERINFOMATION, [ud objectForKey:@"key"]]];
    DLog(@"editUrl = %@",editUrl);
    ASIFormDataRequest *updateRequest = [ASIFormDataRequest requestWithURL:editUrl];
    //头像文件
    NSString *imagestr=[[NSString alloc]initWithFormat:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imagestr];
    DLog(@"提交的路径%@",fullPath);
    NSFileManager *fm = [[NSFileManager alloc]init];
    if ([fm fileExistsAtPath:fullPath]) {
        DLog(@"文件存在,设置表单上传文件字段,图片资源打印%@",[UIImage imageWithContentsOfFile:fullPath]);
        [updateRequest setFile:fullPath forKey:@"con_headimg"];
    }
//    [updateRequest addPostValue:[ud objectForKey:@"key"] forKey:@"key"];
    [updateRequest addPostValue:editName.text forKey:KEY_USER_NAME];
    [updateRequest addPostValue:editTel.text forKey:KEY_USER_PHONE];
    [updateRequest addPostValue:editQQ.text forKey:KEY_USER_QQ];
    [updateRequest addPostValue:editDescription.text forKey:KEY_USER_DESCRIPTION];
    [updateRequest startSynchronous];
    
    NSError *error = [updateRequest error];
    DLog(@"error = %@",error);
    if (!error) {
        NSString *response = [updateRequest responseString];
        DLog(@"response is %@",response);
        NSDictionary *responDict = [[response JSONValue] objectForKey:@"message"];
        DLog(@"responDict is %@",responDict);
        if (responDict==nil||![responDict isKindOfClass:[NSDictionary class]]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"提示") message:NSLocalizedString(@"NSStringServiceReturnExecption",@"服务器异常，请稍后再试！") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"NSStringOKButtonTitle", @""), nil];
            [alert show];
            [alert release];
            return;
        }
        if ([[responDict objectForKey:@"error"] isEqualToString:@"0"]) {
            DLog(@"保存修改");
            [ud setObject:editName.text forKey:KEY_USER_NAME];
            [ud setObject:editTel.text forKey:KEY_USER_PHONE];
            [ud setObject:editQQ.text forKey:KEY_USER_QQ];
            [ud setObject:editDescription.text forKey:KEY_USER_DESCRIPTION];
            [ud setObject:fullPath forKey:KEY_USER_HEADIMG];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_UPDATE_USER_INFORMATION object:self userInfo:nil];
            [self back];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"") message:[responDict objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"NSStringOKButtonTitle", @""), nil];
            [alert show];
            [alert release];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"") message:[responDict objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"NSStringOKButtonTitle", @""), nil];
            [alert show];
            [alert release];
        }
    }else {
        NSLog(@"error accured. %@",error);
    }

}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.2);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    editTableView.frame = CGRectMake(0, -210, 540, 620);
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    editTableView.frame = CGRectMake(0, 10, 540, 620);
}
#pragma mark - UITextFeildDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    editTableView.frame = CGRectMake(0, -130, 540, 620);
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    editTableView.frame = CGRectMake(0, 10, 540, 620);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    CGFloat heightOfCell = cell.frame.size.height;
    DLog(@"heightOfCell = %f",heightOfCell);
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    }
    if (indexPath.section == 0) {
        [cell addSubview:headImageView];
    }
    else if (indexPath.section == 1)
    {
        [cell addSubview:editName];
    }
    else if (indexPath.section == 2)
    {
        [cell addSubview:editTel];
    }
    else if (indexPath.section == 3)
    {
        [cell addSubview:editQQ];
    }
    else
    {
        [cell addSubview:editDescription];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return NSLocalizedString(@"YunPing_headimage", @"头像");
            break;
        case 1:
            return NSLocalizedString(@"YunPing_name", @"名字");
            break;
        case 2:
            return NSLocalizedString(@"YunPing_tel", @"电话");
            break;
        case 3:
            return NSLocalizedString(@"YunPing_qq", @"QQ");
            break;
        default:
            return NSLocalizedString(@"YunPing_aboutdesigner", @"设计师介绍");
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120;
    }
    if (indexPath.section == 4) {
        return 160;
    }
    else{
        return 40;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DLog(@"\nself.view.frame.size.width = %f\nself.view.frame.size.height = %f",self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
