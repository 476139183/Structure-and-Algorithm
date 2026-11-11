//
//  RegisterViewController.m
//  SideBarDemo
//
//  Created by LDY on 13-8-13.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import "RegisterViewController.h"
#import "BaseButton.h"
#import "SVStatusHUD.h"
#import "ASIFormDataRequest.h"
#import "NSString+SBJSON.h"
#import "NSString+MD5.h"
#import "Config.h"
#import "SGInfoAlert.h"
#import "MyTool.h"

#import "NJOPasswordStrengthEvaluator.h"

@interface RegisterViewController ()

@property (readwrite, nonatomic, strong) NJOPasswordValidator *strictValidator;
@property (readonly, nonatomic) NJOPasswordValidator *validator;

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.strictValidator = [NJOPasswordValidator validatorWithRules:@[[NJOLengthRule ruleWithRange:NSMakeRange(8, 16)], [NJORequiredCharacterRule lowercaseCharacterRequiredRule], [NJORequiredCharacterRule uppercaseCharacterRequiredRule], [NJORequiredCharacterRule decimalDigitCharacterRequiredRule]]];
    return self;
}
#pragma mark - 密码验证
- (NJOPasswordValidator *)validator {
    return self.strictValidator;
}
- (BOOL)evaluatePasswordStrength {
    NSString *password = passwordField.text;
    NSArray *failingRules = nil;
    if (![self.validator validatePassword:password failingRules:&failingRules])
    {
        DLog(@"Invalid Password!!!");
        NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] init];
        for (id <NJOPasswordRule> rule in failingRules)
        {
            [mutableAttributedString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"• %@\n", [rule localizedErrorDescription]] attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}]];
            DLog(@"%@",mutableAttributedString);
        }
        NJOPredicateRule *rule = [failingRules firstObject];
        [SGInfoAlert showInfo:[rule localizedErrorDescription]
                      bgColor:[[UIColor darkGrayColor] CGColor]
                       inView:self.view
                     vertical:0.4];
        return NO;
    }
    return YES;
}


//返回登录页面
- (void)goToLogin
{
    NSLog(@"登录账号");
    [MyTool viewSwitcher:@"oglFlip" owner:self transitionFromStyle:kCATransitionFromRight];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_background"]]];
    self.title = NSLocalizedString(@"NSString39", @"");
//    self.navigationController.navigationItem.hidesBackButton = YES;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"NSString40",@"登录") style:UIBarButtonItemStyleBordered target:self action:@selector(goToLogin)];
    
    UIScrollView *mainFloorScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    DLog(@"self.view.frame.size.height = %f",self.view.frame.size.height);
    DLog(@"self.navigationController.view.frame.size.width = %f",self.navigationController.view.frame.size.width);
    [mainFloorScrollView setContentSize:CGSizeMake(self.navigationController.view.frame.size.width,self.view.frame.size.height - 1)];
    [mainFloorScrollView setUserInteractionEnabled:YES];
    [mainFloorScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:mainFloorScrollView];
    
    
    UILabel *bitianLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 320, 30)];
    [bitianLabel setText:NSLocalizedString(@"NSStringMustWrite", @"必填")];
    [bitianLabel setBackgroundColor:[UIColor clearColor]];
    [bitianLabel setTextColor:[UIColor redColor]];
    [mainFloorScrollView addSubview:bitianLabel];
    

    NSInteger labelWidth = 100;
    NSInteger rowHeight = 30;
    NSInteger myfontsize = 12;
    
    UILabel *nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+bitianLabel.frame.origin.y+bitianLabel.frame.size.height,labelWidth,rowHeight)];
    [nicknameLabel setBackgroundColor:[UIColor clearColor]];
    [nicknameLabel setTextColor:[UIColor blackColor]];
    [nicknameLabel setNumberOfLines:2];
    [nicknameLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [nicknameLabel setFont:[UIFont systemFontOfSize:myfontsize]];
    [nicknameLabel setText:NSLocalizedString(@"NSStringName", @"姓名")];
    [mainFloorScrollView addSubview:nicknameLabel];
    
    nicknameField = [[UITextField alloc] initWithFrame:CGRectMake(labelWidth+20,10+bitianLabel.frame.origin.y+bitianLabel.frame.size.height, self.navigationController.view.frame.size.width-40-labelWidth, 40)];
    nicknameField.background = [UIImage imageNamed:@"Customer_singal.png"];
    nicknameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nicknameField.placeholder = NSLocalizedString(@"NSStringNamePlaceholder",@"姓名");
    nicknameField.tag = 1000;
    nicknameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nicknameField.textAlignment = NSTextAlignmentCenter;
    nicknameField.adjustsFontSizeToFitWidth = YES;
    nicknameField.delegate = self;

    
    UILabel *companynameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+nicknameField.frame.origin.y+nicknameField.frame.size.height,labelWidth,rowHeight)];
    [companynameLabel setBackgroundColor:[UIColor clearColor]];
    [companynameLabel setTextColor:[UIColor blackColor]];
    [companynameLabel setNumberOfLines:2];
    [companynameLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [companynameLabel setFont:[UIFont systemFontOfSize:myfontsize]];
    [companynameLabel setText:NSLocalizedString(@"NSStringcompanynameLabel", @"公司名称")];
    [mainFloorScrollView addSubview:companynameLabel];
    
    companyField = [[UITextField alloc] initWithFrame:CGRectMake(labelWidth+20,10+nicknameField.frame.origin.y+nicknameField.frame.size.height, self.navigationController.view.frame.size.width-40-labelWidth, 40)];
    companyField.background = [UIImage imageNamed:@"Customer_singal.png"];
    companyField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    companyField.placeholder = NSLocalizedString(@"NSStringcompanynameLabelPlaceholder", @"公司名称");
    companyField.tag = 1001;
    companyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    companyField.textAlignment = NSTextAlignmentCenter;
    companyField.adjustsFontSizeToFitWidth = YES;
    companyField.delegate = self;
    
    

    UILabel *phonenumLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+companyField.frame.origin.y+companyField.frame.size.height,labelWidth,rowHeight)];
    [phonenumLabel setBackgroundColor:[UIColor clearColor]];
    [phonenumLabel setTextColor:[UIColor blackColor]];
    [phonenumLabel setNumberOfLines:2];
    [phonenumLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [phonenumLabel setFont:[UIFont systemFontOfSize:myfontsize]];
    NSString* strLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    if ([strLanguage isEqualToString:@"en"]) {
        [phonenumLabel setText:NSLocalizedString(@"NSStringemailLabel", @"邮箱地址")];
    }
    else{
       [phonenumLabel setText:NSLocalizedString(@"NSStringtelphoneLabel", @"手机号码")]; 
    }
    
    [mainFloorScrollView addSubview:phonenumLabel];
    
    phonenumField = [[UITextField alloc] initWithFrame:CGRectMake(labelWidth+20,10+companyField.frame.origin.y+companyField.frame.size.height, self.navigationController.view.frame.size.width-40-labelWidth, 40)];
    phonenumField.background = [UIImage imageNamed:@"Customer_singal.png"];
    phonenumField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if ([strLanguage isEqualToString:@"en"]) {
        phonenumField.placeholder = NSLocalizedString(@"NSStringemailLabelPlaceholder",@"邮箱地址");
    }
    else{
        phonenumField.placeholder = NSLocalizedString(@"NSStringtelphoneLabelPlaceholder",@"手机号码");
    }
    
    phonenumField.tag = 1002;
    phonenumField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phonenumField.textAlignment = NSTextAlignmentCenter;
    phonenumField.adjustsFontSizeToFitWidth = YES;
    phonenumField.delegate = self;
    
    

    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+phonenumField.frame.origin.y+phonenumField.frame.size.height,labelWidth,rowHeight)];
    [passwordLabel setBackgroundColor:[UIColor clearColor]];
    [passwordLabel setNumberOfLines:2];
    [passwordLabel setFont:[UIFont systemFontOfSize:myfontsize]];
    [passwordLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [passwordLabel setTextColor:[UIColor blackColor]];
    [passwordLabel setText:NSLocalizedString(@"NSStringpasswordLabel", @"密码")];
    [mainFloorScrollView addSubview:passwordLabel];
    
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(labelWidth+20,10+phonenumField.frame.origin.y+phonenumField.frame.size.height, self.navigationController.view.frame.size.width-40-labelWidth, 40)];
    passwordField.background = [UIImage imageNamed:@"Customer_singal.png"];
    passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordField.secureTextEntry = YES;
    passwordField.placeholder = NSLocalizedString(@"NSStringpasswordLabelPlaceholder",@"密码");
    passwordField.tag = 1003;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.textAlignment = NSTextAlignmentCenter;
    passwordField.adjustsFontSizeToFitWidth = YES;
    passwordField.delegate = self;
    
    
    UILabel *confirmpasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+passwordField.frame.origin.y+passwordField.frame.size.height,labelWidth,rowHeight)];
    [confirmpasswordLabel setBackgroundColor:[UIColor clearColor]];
    [confirmpasswordLabel setNumberOfLines:2];
    [confirmpasswordLabel setFont:[UIFont systemFontOfSize:myfontsize]];
    [confirmpasswordLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [confirmpasswordLabel setTextColor:[UIColor blackColor]];
    [confirmpasswordLabel setText:NSLocalizedString(@"NSStringconfirmpassLabel",@"确认密码")];
    [mainFloorScrollView addSubview:confirmpasswordLabel];
    
    
    confirmField = [[UITextField alloc] initWithFrame:CGRectMake(labelWidth+20,10+passwordField.frame.origin.y+passwordField.frame.size.height, self.navigationController.view.frame.size.width-40-labelWidth, 40)];
    confirmField.background = [UIImage imageNamed:@"Customer_singal.png"];
    confirmField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    confirmField.secureTextEntry = YES;
    confirmField.placeholder = NSLocalizedString(@"NSStringconfirmpassLabelPlaceholder",@"确认密码");
    confirmField.tag = 1003;
    confirmField.clearButtonMode = UITextFieldViewModeWhileEditing;
    confirmField.textAlignment = NSTextAlignmentCenter;
    confirmField.adjustsFontSizeToFitWidth = YES;
    confirmField.delegate = self;
    
    UILabel *optionalLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+confirmField.frame.origin.y+confirmField.frame.size.height,labelWidth,rowHeight)];
    [optionalLabel setText:NSLocalizedString(@"NSStringoptionalLabel", @"选填")];
    [optionalLabel setBackgroundColor:[UIColor clearColor]];
    [optionalLabel setTextColor:[UIColor redColor]];
    [mainFloorScrollView addSubview:optionalLabel];
    
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+optionalLabel.frame.origin.y+optionalLabel.frame.size.height,labelWidth,rowHeight)];
    [emailLabel setBackgroundColor:[UIColor clearColor]];
    [emailLabel setNumberOfLines:2];
    [emailLabel setFont:[UIFont systemFontOfSize:myfontsize]];
    [emailLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [emailLabel setTextColor:[UIColor blackColor]];
    if ([strLanguage isEqualToString:@"en"]) {
        [emailLabel setText:NSLocalizedString(@"NSStringtelphoneLabel",@"手机号码")];
    }
    else{
        [emailLabel setText:NSLocalizedString(@"NSStringemailLabel",@"邮箱地址")];
        
    }
    
    [mainFloorScrollView addSubview:emailLabel];
    
    
    emailField = [[UITextField alloc] initWithFrame:CGRectMake(labelWidth+20,10+optionalLabel.frame.origin.y+optionalLabel.frame.size.height, self.navigationController.view.frame.size.width-40-labelWidth, 40)];
    emailField.background = [UIImage imageNamed:@"Customer_singal.png"];
    emailField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if ([strLanguage isEqualToString:@"en"]) {
        emailField.placeholder = NSLocalizedString(@"NSStringphoneLabelPlaceholder",@"手机号码");
    }else{
        emailField.placeholder = NSLocalizedString(@"NSStringemailLabelPlaceholder",@"邮箱地址");
    }
    
    emailField.tag = 1003;
    emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailField.textAlignment = NSTextAlignmentCenter;
    emailField.adjustsFontSizeToFitWidth = YES;
    emailField.delegate = self;
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+emailField.frame.origin.y+emailField.frame.size.height,labelWidth,rowHeight)];
    [addressLabel setBackgroundColor:[UIColor clearColor]];
    [addressLabel setNumberOfLines:2];
    [addressLabel setFont:[UIFont systemFontOfSize:myfontsize]];
    [addressLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [addressLabel setTextColor:[UIColor blackColor]];
    [addressLabel setText:NSLocalizedString(@"NSStringcompanyaddressLabel",@"地址")];
    [mainFloorScrollView addSubview:addressLabel];
    
    
    addressField = [[UITextField alloc] initWithFrame:CGRectMake(labelWidth+20,10+emailField.frame.origin.y+emailField.frame.size.height, self.navigationController.view.frame.size.width-40-labelWidth, 40)];
    addressField.background = [UIImage imageNamed:@"Customer_singal.png"];
    addressField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    addressField.placeholder = NSLocalizedString(@"NSStringcompanyaddressLabelPlaceholder",@"地址");
    addressField.tag = 1003;
    addressField.clearButtonMode = UITextFieldViewModeWhileEditing;
    addressField.textAlignment = NSTextAlignmentCenter;
    addressField.adjustsFontSizeToFitWidth = YES;
    addressField.delegate = self;
    

    [mainFloorScrollView addSubview:emailField];
    [mainFloorScrollView addSubview:phonenumField];
    [mainFloorScrollView addSubview:passwordField];
    [mainFloorScrollView addSubview:confirmField];
    [mainFloorScrollView addSubview:companyField];
    [mainFloorScrollView addSubview:nicknameField];
    [mainFloorScrollView addSubview:addressField];
    

    
    BaseButton *registerButton = [[BaseButton alloc] initWithFrame:CGRectMake(20,30+addressField.frame.origin.y+addressField.frame.size.height, self.navigationController.view.frame.size.width-40, 40) andNorImg:@"navi_button1_l.png" andHigImg:nil andTitle:NSLocalizedString(@"NSString39", @"")];
    [registerButton addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [mainFloorScrollView addSubview:registerButton];
    [registerButton release];
    

}



- (void)dealloc
{
    [emailField release];
    [phonenumField release];
    [passwordField release];
    [confirmField release];
    
    [super dealloc];
}

-(void)SystembackMainSettingView
{
    [self.navigationController popViewControllerAnimated:YES];
}

//本地验证，登录时先进行本地验证通过后再与后台交互验证
/**
 *@brief 判断输入的时email还是手机号码
 */
- (BOOL)localRegex
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9._]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    if (![emailTest evaluateWithObject:phonenumField.text]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void) registerButtonClicked:(id) sender
{
    self.view.frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.view.frame.size.height);
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];

    //本地注册验证信息完成
    /*
     *************************************************************
     */
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",URL_FOR_IP_OR_DOMAIN,URL_ZDEC_REGISTER]];
    DLog(@"注册请求 ＝ %@",url);
    ASIFormDataRequest *loginRequest = [ASIFormDataRequest requestWithURL:url];
    if ([nicknameField.text length]<2) {
        [SGInfoAlert showInfo:NSLocalizedString(@"NSStringnameLengthPlaceholder",@"姓名长度不小于2个汉字")
                      bgColor:[[UIColor darkGrayColor] CGColor]
                       inView:self.view
                     vertical:0.4];
        return;
    }
    if ([companyField.text length]<1) {
        [SGInfoAlert showInfo:NSLocalizedString(@"NSStringCompanynameLengthError",@"公司名称不能为空")
                      bgColor:[[UIColor darkGrayColor] CGColor]
                       inView:self.view
                     vertical:0.4];
        return;
    }
    
    NSString *usermail = emailField.text;
    NSString *phonenum = phonenumField.text;
    NSString *language = @"cn";
    //如果是中文环境的情况下
    NSString* strLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    if ([strLanguage isEqualToString:@"zh-Hans"]) {
        if ([phonenumField.text length]!=11) {
            [SGInfoAlert showInfo:NSLocalizedString(@"NSStringphoneLengthError",@"电话号码长度不正确")
                          bgColor:[[UIColor darkGrayColor] CGColor]
                           inView:self.view
                         vertical:0.4];
            return;
        }
//        [loginRequest addPostValue:emailField.text forKey:@"m"];
        usermail = emailField.text;
//        [loginRequest addPostValue:phonenumField.text forKey:@"p"];
        phonenum = phonenumField.text;
//        [loginRequest addPostValue:@"cn" forKey:@"lang"];
        language = @"cn";
    }else{
        //英文环境下
        NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
        if (![emailTest evaluateWithObject:phonenumField.text]) {
            [SGInfoAlert showInfo:NSLocalizedString(@"NSString11",@"邮箱格式不正确")
                          bgColor:[[UIColor darkGrayColor] CGColor]
                           inView:self.view
                         vertical:0.4];
            return;
        }

//        [loginRequest addPostValue:emailField.text forKey:@"p"];//邮箱
        phonenum = emailField.text;
//        [loginRequest addPostValue:phonenumField.text forKey:@"m"];//手机
        usermail = phonenumField.text;
//        [loginRequest addPostValue:@"en" forKey:@"lang"];
        language = @"en";
        
    }
//    [loginRequest addPostValue:passwordField.text forKey:@"w"];//密码
//    [loginRequest addPostValue:nicknameField.text forKey:@"n"];//姓名
//    
//    [loginRequest addPostValue:addressField.text forKey:@"ab"];//地址
//    [loginRequest addPostValue:companyField.text forKey:@"c"];//公司
    
    BOOL issendRequest=YES;
    //    2014年08月11日15:05:28---新的密码验证规则
    //    if ([passwordField.text length]<8) {
    //        [SGInfoAlert showInfo:NSLocalizedString(@"NSStringpasswordLengthPlaceholder",@"密码长度不小于8位")
    //                      bgColor:[[UIColor darkGrayColor] CGColor]
    //                       inView:self.view
    //                     vertical:0.4];
    //        issendRequest=NO;
    //        return;
    //    }
    if (![self evaluatePasswordStrength]) {
        issendRequest=NO;
        return;
    }
    
    if (![passwordField.text isEqualToString:confirmField.text]) {
        [SGInfoAlert showInfo:NSLocalizedString(@"NSStringpasswordisEqualPlaceholder",@"密码与确认密码不相等")
                      bgColor:[[UIColor darkGrayColor] CGColor]
                       inView:self.view
                     vertical:0.4];
        issendRequest=NO;
        return;
    }

    
    NSMutableDictionary *postFormDict = [[NSMutableDictionary alloc]init];
    //邮箱
    if (usermail) {
        [postFormDict setObject:usermail forKey:@"m"];
        messageDict = [[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"NSString63",@"注册成功"),@"message", nil];
    }
    //手机
    if (phonenum) {
        [postFormDict setObject:phonenum forKey:@"p"];
        messageDict = [[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"NSStringRegSuccess",@"注册成功"),@"message", nil];
    }
    //密码
    [postFormDict setObject:[passwordField.text md5EncryptLower] forKey:@"w"];
    //姓名
    [postFormDict setObject:nicknameField.text forKey:@"n"];
    //地址
    [postFormDict setObject:addressField.text forKey:@"ab"];
    //公司名
    [postFormDict setObject:companyField.text forKey:@"c"];
    //companyid
    [postFormDict setObject:KEY_COMPANY_ID forKey:KEY_CID];
    //注册人的语言
    [postFormDict setObject:language forKey:@"lang"];
    DLog(@"postform = %@",postFormDict);
    
    for (NSString *postKey in postFormDict) {
        [loginRequest addPostValue:[postFormDict objectForKey:postKey] forKey:postKey];
    }
    
    if (issendRequest==YES) {
        [loginRequest startSynchronous];
    }
    
    NSError *error = [loginRequest error];
    if (!error) {
        NSString *response = [loginRequest responseString];
        DLog(@"data received is %@",response);
        NSDictionary *responDict = [[response JSONValue] objectForKey:@"message"];
        DLog(@"message=%@",responDict);
        NSString *resMessageString = [responDict objectForKey:@"msg"];
        DLog(@"responDict objectForKey=%@",resMessageString);
        if (resMessageString==nil) {
        resMessageString=NSLocalizedString(@"NSStringServiceErrorRegFaild",@"注册失败");
        }
        if ([[responDict objectForKey:@"error"] isEqualToString:@"0"]) {
            //销售员和客户的key
            NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
            [ud setObject:[responDict objectForKey:@"key"] forKey:@"key"];
            [self clearTextField];
            //NSDictionary *messageDict = [[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"NSStringRegSuccess",@"注册成功"),@"message", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_SHOW_LOGIN_SUCCESS_TOASTVIEW object:nil userInfo:messageDict];
            [self SystembackMainSettingView];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"") message:resMessageString delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"NSStringOKButtonTitle", @""), nil];
            [alert show];
            [alert release];
        }
    }else {
        DLog(@"error accured. %@",error);
    }


}

-(void)clearTextField{
    //邮箱地址
    [emailField setText:@""];
    //手机号码
    [phonenumField setText:@""];
    //密码
    [passwordField setText:@""];
    //确认密码
    [confirmField setText:@""];
    //公司名称
    [companyField setText:@""];
    //昵称
    [nicknameField setText:@""];
    //地址
    [addressField setText:@""];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.view.frame.size.height);
    return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if ( [textField isEqual:emailField]||[textField isEqual:addressField]) {
        self.view.frame = CGRectMake(0, -150, self.navigationController.view.frame.size.width, self.view.frame.size.height+150);
    }
    return YES;
}

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    if ([textField isEqual:emailField] ||[textField isEqual:addressField]) {
//        self.view.frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.view.frame.size.height+150);
    }
    return YES;
}

-(bool)checkDevice:(NSString*)name
{
    NSString* deviceType = [UIDevice currentDevice].model;
    DLog(@"deviceType = %@", deviceType);
    
    NSRange range = [deviceType rangeOfString:name];
    return range.location != NSNotFound;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSString *  nsStrIphone=@"iPhone";
    NSString *  nsStrIpod=@"iPod";
    NSString *  nsStrIpad=@"iPad";
    bool  bIsiPhone=false;
    bool  bIsiPod=false;
    bool  bIsiPad=false;
    bIsiPhone=[self  checkDevice:nsStrIphone];
    bIsiPod=[self checkDevice:nsStrIpod];
    bIsiPad=[self checkDevice:nsStrIpad];
    
    
    if (bIsiPhone == true || bIsiPod == true) {
        if (textField.tag == 1002 ||textField.tag == 1003) {
            self.view.frame = CGRectMake(0, -150, self.navigationController.view.frame.size.width, self.view.frame.size.height);
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *  nsStrIphone=@"iPhone";
    NSString *  nsStrIpod=@"iPod";
    NSString *  nsStrIpad=@"iPad";
    bool  bIsiPhone=false;
    bool  bIsiPod=false;
    bool  bIsiPad=false;
    bIsiPhone=[self checkDevice:nsStrIphone];
    bIsiPod=[self checkDevice:nsStrIpod];
    bIsiPad=[self checkDevice:nsStrIpad];
    
    if (bIsiPhone == true &&bIsiPod == true) {
        if (textField.tag == 1003) {
//            self.view.frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.view.frame.size.height);
        }
    }
}
//

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setBool:YES forKey:@"isOneButton"];
}
-(void)viewDidDisappear:(BOOL)animated{
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setBool:NO forKey:@"isOneButton"];
}
@end
