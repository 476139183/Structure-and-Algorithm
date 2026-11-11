//
//  ModifyPassViewController.m
//  ZDEC
//
//  Created by yixingman on 9/11/13.
//  Copyright (c) 2013 JianYe. All rights reserved.
//

#import "ModifyPassViewController.h"
#import "BaseButton.h"
#import "BaseUILabel.h"
#import "BaseTextField.h"
#import "ASIFormDataRequest.h"
#import "NSString+SBJSON.h"
#import "NSString+MD5.h"
#import "Config.h"

@interface ModifyPassViewController ()

@end

@implementation ModifyPassViewController

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
	// Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"NSStringModifyPass", @"修改密码");
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackGround.png"]]];
    
    originalButton = [[BaseButton alloc] initWithFrame:CGRectMake(10, 10 + [Config currentNavigateHeight], SCREEN_CGSIZE_WIDTH-20, 40) andNorImg:@"Customer_Up.png" andHigImg:nil andTitle:nil];
    originalLabel = [[BaseUILabel alloc] initWithFrame:CGRectMake(5, 5, 70, 30) andTitle:@"原密码"];//@"公司"
    originalTextField = [[BaseTextField alloc] initWithFrame:CGRectMake(75, 5, SCREEN_CGSIZE_WIDTH-40, 30) andPlaceholder:nil];
    originalTextField.backgroundColor = [UIColor clearColor];
    originalTextField.borderStyle = UITextBorderStyleNone;
    originalTextField.secureTextEntry = YES;
    originalTextField.delegate = self;
    [originalButton addSubview:originalLabel];
    [originalButton addSubview:originalTextField];
    [self.view     addSubview:originalButton];
    
    new1Button = [[BaseButton alloc] initWithFrame:CGRectMake(10, 50 + [Config currentNavigateHeight], SCREEN_CGSIZE_WIDTH-20, 40) andNorImg:@"Customer_center.png" andHigImg:nil andTitle:nil];
    new1Label = [[BaseUILabel alloc] initWithFrame:CGRectMake(5, 5, 70, 30) andTitle:@"新密码"];//@"公司"
    new1TextField = [[BaseTextField alloc] initWithFrame:CGRectMake(75, 5, SCREEN_CGSIZE_WIDTH-40, 30) andPlaceholder:nil];
    new1TextField.backgroundColor = [UIColor clearColor];
    new1TextField.borderStyle = UITextBorderStyleNone;
    new1TextField.secureTextEntry = YES;
    new1TextField.delegate = self;
    [new1Button addSubview:new1Label];
    [new1Button addSubview:new1TextField];
    [self.view     addSubview:new1Button];
    
    new2Button = [[BaseButton alloc] initWithFrame:CGRectMake(10, 90 + [Config currentNavigateHeight], SCREEN_CGSIZE_WIDTH-20, 40) andNorImg:@"Customer_Down.png" andHigImg:nil andTitle:nil];
    new2Label = [[BaseUILabel alloc] initWithFrame:CGRectMake(5, 5, 70, 30) andTitle:@"新密码"];//@"公司"
    new2TextField = [[BaseTextField alloc] initWithFrame:CGRectMake(75, 5, SCREEN_CGSIZE_WIDTH-40, 30) andPlaceholder:nil];
    new2TextField.backgroundColor = [UIColor clearColor];
    new2TextField.borderStyle = UITextBorderStyleNone;
    new2TextField.secureTextEntry = YES;
    new2TextField.delegate = self;
    [new2Button addSubview:new2Label];
    [new2Button addSubview:new2TextField];
    [self.view     addSubview:new2Button];
    
    confirmButton = [[BaseButton alloc]initWithFrame:CGRectMake(10, 150 + [Config currentNavigateHeight], SCREEN_CGSIZE_WIDTH-20, 40) andNorImg:@"navi_button1_l.png" andHigImg:@"navi_button1_l.png" andTitle:@"确认修改"];
    [confirmButton addTarget:self action:@selector(confirmButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
    
}

- (void)confirmButton:(id)sender
{
    if ([originalTextField.text isEqualToString:new1TextField.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"提示") message:NSLocalizedString(@"NSStringyuanmimahexinmimabuneng", @"原密码和新密码不能相同") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"确定", @""), nil];
        [alert show];
        [alert release];
        return;
    }
    if ([new1TextField.text isEqualToString:new2TextField.text]) {
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];

        NSString *keyString = [ud objectForKey:@"key"];
        if ([keyString length]<8) {
            keyString = @"";
        }
         DLog(@"%@",keyString);
        
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",URL_FOR_IP_OR_DOMAIN,URL_ZDEC_PASS_EDIT,keyString]];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?key=%@",URL_FOR_IP_OR_DOMAIN,URL_ZDEC_PASS_EDIT,keyString]];

        ASIFormDataRequest *modifyRequest = [[ASIFormDataRequest alloc]initWithURL:url];
        
        [modifyRequest addPostValue:[originalTextField.text md5Encrypt] forKey:@"o_pass"];
        [modifyRequest addPostValue:[new1TextField.text md5Encrypt] forKey:@"pass"];
        //转接口之后新增
        [modifyRequest addPostValue:KEY_COMPANY_ID forKey:KEY_CID];
        DLog(@"o_pass = %@",originalTextField.text);
        DLog(@"pass = %@",new1TextField.text);
        DLog(@"cid = %@",KEY_COMPANY_ID);
        [modifyRequest startSynchronous];
        
        NSString *respons = [modifyRequest responseString];
        NSDictionary *confirmDict1 = [respons JSONValue];
        DLog(@"%@",respons);
        DLog(@"%@",[confirmDict1 objectForKey:@"message"]);
        DLog(@"%@",[[confirmDict1 objectForKey:@"message"] objectForKey:@"msg"]);
        
        
        
        if ([[[confirmDict1 objectForKey:@"message"] objectForKey:@"error"] isEqualToString:@"0"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSStringModifySuccess", @"密码修改成功") message:[[confirmDict1 objectForKey:@"message"] objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"确定", @""), nil];
            [alert show];
            [alert release];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"修改失败" message:[[confirmDict1 objectForKey:@"message"] objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"确定", @""), nil];
            [alert show];
            [alert release];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"修改失败" message:@"您的新密码和确认密码不一致！" delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"确定", @""), nil];
        [alert show];
        [alert release];
    }
    

}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
