//
//  DYT_LoginPage.m
//  LEDAD
//
//  Created by laidiya on 15/7/22.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_LoginPage.h"
#import "Config.h"
#define LINESPACE 10

@implementation DYT_LoginPage
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;



}
-(void)_init{
    
    _usernameTextField = [[UITextField alloc]init];
    _usernameTextField.delegate = self;
    _usernameTextField.tag = 1;
    
    _passwordTextField = [[UITextField alloc]init];
    _passwordTextField.delegate = self;
    _passwordTextField.tag = 2;
    
    _messageTextField = [[UITextField alloc]init];
    _messageTextField.delegate = self;
    _messageTextField.tag = 3;
    
    
    
    _pooCodeView =[[PooCodeView alloc]init];
    
    
    _loginButton = [[UIButton alloc]init];
    
    _registeredButton = [[UIButton alloc]init];
    
    
    [self setMyViewFrame];
}


-(void)setMyViewFrame{
    
    UILabel *labUserName = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 50, 30)];
    labUserName.text = [Config DPLocalizedString:@"Login_Account"];
    
    _usernameTextField.frame = CGRectMake(60, 30, 180, 30);
    _usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _usernameTextField.keyboardType = UIKeyboardTypePhonePad;
    [_usernameTextField setPlaceholder:[Config DPLocalizedString:@"Login_AccountTS"]];
    
    
    UILabel *labPassWord = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 50, 30)];
    labPassWord.text = [Config DPLocalizedString:@"Login_Password"];
    
    _passwordTextField.frame = CGRectMake(60, 80, 180, 30) ;
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.secureTextEntry = YES;
    [_passwordTextField setPlaceholder:[Config DPLocalizedString:@"Login_PasswordTS"]];
    
    
    UILabel *labmessagelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 70, 30)];
    labmessagelabel.text = [Config DPLocalizedString:@"Login_yzm"];
    
    //    验证码框
    _messageTextField.frame = CGRectMake(100, 150, 80, 30);
    _messageTextField.borderStyle = UITextBorderStyleRoundedRect;
    _messageTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _pooCodeView.frame = CGRectMake(200, 150, 80, 30);
    
    
    _loginButton.frame = CGRectMake(_messageTextField.frame.origin.x, 200, 80, 30);
    [_loginButton setTitle:[Config DPLocalizedString:@"Login_btn"] forState:0];
    [_loginButton addTarget:self action:@selector(loginButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    _loginButton.backgroundColor = [UIColor blueColor];
    
    
//
    UILabel *textlabel = [[UILabel alloc]initWithFrame:CGRectMake(5, _loginButton.frame.origin.y+40, self.frame.size.width, 120)];
    
    NSString *labelText = [NSString stringWithFormat:@"\t%@\n%@",[Config DPLocalizedString:@"Login_ts"],[Config DPLocalizedString:@"Login_ts2"]];

    textlabel.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:LINESPACE];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
     textlabel.attributedText = attributedString;
    
    
    [self addSubview:textlabel];
    
    
    _registeredButton.frame = CGRectMake(self.frame.size.width-130, textlabel.frame.origin.y+15, 130, 30);
    [_registeredButton addTarget:self action:@selector(registeredButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    _registeredButton.backgroundColor = [UIColor clearColor];
    [_registeredButton setTitle:[Config DPLocalizedString:@"Login_ts1"] forState:0];
    [_registeredButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self addSubview:labUserName];
    [self addSubview:labPassWord];
    [self addSubview:labmessagelabel];
    [self addSubview:_usernameTextField];
    [self addSubview:_passwordTextField];
    [self addSubview:_messageTextField];
    [self addSubview:_pooCodeView];
    [self addSubview:_loginButton];
    [self addSubview:_registeredButton];
    
}


-(void)loginButtonOnClick:(id)sender{
    
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_messageTextField resignFirstResponder];
    
    
    
    _loginButtonOnClick();
    
    
    
    
    
}



-(void)registeredButtonOnClick:(id)sender{
    
    
    _registeredButtonOnClick();
    
    
}


#pragma mark -UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"Begin Editing");
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //开始编辑时触发，文本字段将成为first responder
}




- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField.tag == 1){
        
        _userName_text(textField.text);
        
    }
    if(textField.tag == 2){
        
        
        _passWord_text(textField.text);
    }
    if (textField.tag == 3) {
        
        _message_text(textField.text);
    }
    
    
    return YES;
}
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField.tag == 3)
    {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if ([toBeString length] > 4) {
            _messageTextField.text = [toBeString substringToIndex:4];
            return NO;
        }
    }
    return YES;
    return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField.tag == 1){
        
        _userName_text(textField.text);
        
    }
    
    if (textField.tag == 2){
        
        
        _passWord_text(textField.text);
    }
    if (textField.tag == 3) {
        _message_text(textField.text);
    }
    
    return YES;
}
-(void)resignAllTextFieldResponder
{
    [_passwordTextField resignFirstResponder];
    [_usernameTextField resignFirstResponder];
    [_messageTextField resignFirstResponder];
}//注销第一响应者


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    [super touchesEnded:touches withEvent:event];
    
    [self resignAllTextFieldResponder];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
