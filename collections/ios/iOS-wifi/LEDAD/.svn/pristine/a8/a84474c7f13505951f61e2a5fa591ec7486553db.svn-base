//
//  YXM_ RegisteredPage.m
//  LEDAD
//
//  Created by 安静。 on 15/7/1.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "YXM_RegisteredPage.h"
#import "Config.h"

@implementation YXM_RegisteredPage


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self _init];
    }
    
    return self;
}


-(void)_init{

    _userNameTextField = [[UITextField alloc]init];
    _userNameTextField.delegate=self;
    _userNameTextField.tag = 1;
    
    
    
    _passWordTextField = [[UITextField alloc]init];
    _passWordTextField.delegate = self;
    _passWordTextField.tag = 2;
    
    
    
    _againPassWordTextField = [[UITextField alloc]init];
    _againPassWordTextField.delegate = self;
    _againPassWordTextField.tag = 3;
    
    
    
    _messageTextField = [[UITextField alloc]init];
    _messageTextField.delegate = self;
    _messageTextField.tag = 4;
    
    
    
    _pooCodeView =[[PooCodeView alloc]init];
    
    _determineButton = [[UIButton alloc]init];

    _returnButton = [[UIButton alloc]init];
    
    
    [self setMyViewFrame];
    
}


-(void)setMyViewFrame{
    
    UILabel *labUserName = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 50, 30)];
    labUserName.text = [Config DPLocalizedString:@"Login_Account"];
    
    _userNameTextField.frame = CGRectMake(100, 30, 180, 30);
    _userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _userNameTextField.keyboardType = UIKeyboardTypePhonePad;
    
    UILabel *labPassWord = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 50, 30)];
    labPassWord.text = [Config DPLocalizedString:@"Login_Password"];
    
    _passWordTextField.frame = CGRectMake(100, 70, 180, 30) ;
    _passWordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passWordTextField.secureTextEntry = YES;

    
    UILabel *labAgainText = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 70, 30)];
    labAgainText.text = [Config DPLocalizedString:@"adedit_zc1"];
    

    _againPassWordTextField.frame = CGRectMake(100, 110, 180, 30);
    _againPassWordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _againPassWordTextField.secureTextEntry = YES;
    
    UILabel *labMessage = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 70, 30)];
    labMessage.text = [Config DPLocalizedString:@"Login_yzm"];
    
    _messageTextField.frame = CGRectMake(100, 150, 80, 30);
    _messageTextField.borderStyle = UITextBorderStyleRoundedRect;
    _messageTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    
    _pooCodeView.frame = CGRectMake(200, 150, 80, 30);
    
    
    
    _determineButton.frame = CGRectMake(200, 200, 80, 30);
    [_determineButton setTitle:[Config DPLocalizedString:@"adedit_zc2"] forState:0];
    _determineButton.backgroundColor = [UIColor blueColor];
    [_determineButton addTarget:self action:@selector(determineButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _returnButton.frame = CGRectMake(60, 200, 80, 30);
    [_returnButton setTitle:[Config DPLocalizedString:@"adedit_back"] forState:0];
    _returnButton.backgroundColor = [UIColor blueColor];
    [_returnButton addTarget:self action:@selector(returnButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self addSubview:labUserName];
    [self addSubview:labPassWord];
    [self addSubview:labAgainText];
    [self addSubview:labMessage];
    [self addSubview:_userNameTextField];
    [self addSubview:_passWordTextField];
    [self addSubview:_againPassWordTextField];
    [self addSubview:_messageTextField];
    [self addSubview:_pooCodeView];
    [self addSubview:_determineButton];
    [self addSubview:_returnButton];
    
}

-(void)returnButtonOnClick:(id)sender{

//    返回
    _userNameTextField.text=@"";
    _passWordTextField.text=@"";
    _againPassWordTextField.text=@"";
    _messageTextField.text=@"";

    [_userNameTextField resignFirstResponder];
    [_passWordTextField resignFirstResponder];
    [_againPassWordTextField resignFirstResponder];
    [_messageTextField resignFirstResponder];
    
    
    _returnButtonOnClick();

}


-(void)determineButtonOnClick:(id)sender{
    
    [_userNameTextField resignFirstResponder];
    [_passWordTextField resignFirstResponder];
    [_againPassWordTextField resignFirstResponder];
    [_messageTextField resignFirstResponder];
    
    NSLog(@"注册");
    
    _determineButtonOnClick();

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
        
        
    }else if (textField.tag == 2){
    
        _passWord_text(textField.text);
    
    }else if(textField.tag == 3){
    
        _againPassWord_text(textField.text);
        
    }else if (textField.tag == 4){
    
        _message_text(textField.text);
    
    }

    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (textField.tag == 4)
    {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];

        if ([toBeString length] > 4) {
            _messageTextField.text = [toBeString substringToIndex:4];
            return NO;
        }
    }
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
        
        
    }else if (textField.tag == 2){
        
        _passWord_text(textField.text);
        
    }else if(textField.tag == 3){
        
        _againPassWord_text(textField.text);
        
    }else if (textField.tag == 4){
        
        _message_text(textField.text);
        
    }
    
    return YES;
}
-(void)resignAllTextFieldResponder
{
    [_passWordTextField resignFirstResponder];
    [_userNameTextField resignFirstResponder];
    [_againPassWordTextField resignFirstResponder];
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
