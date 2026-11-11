//
//  LanguageSettingViewController.m
//  XCloudManager
//
//  Created by LDY on 13-9-21.
//
//

#import "LanguageSettingViewController.h"
#import "BaseButton.h"
#import "Config.h"
#import "LoginViewController.h"
#import "SplitVCDemoViewController.h"

@interface LanguageSettingViewController ()

@end

@implementation LanguageSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGRect rectContainerView = CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-20);
    if (OS_VERSION_FLOAT>7.9) {
        rectContainerView = CGRectMake(0, 0, self.view.frame.size.width-320,self.view.frame.size.height-20);
    }
    
    
//    UIButton *
    
    containerView = [[UIView alloc]initWithFrame:rectContainerView];
    [self.view addSubview:containerView];
    
    NSString *topnavistr=[[NSString alloc]initWithFormat:@"置顶横条"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:topnavistr]];
    titleImageView.frame = CGRectMake(0, 0, containerView.frame.size.width, 44);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [Config DPLocalizedString:@"Root_LanguageSettings"];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleImageView addSubview:titleLabel];
    [titleLabel release];
    [containerView addSubview:titleImageView];
    [titleImageView release];
    
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake((containerView.frame.size.width-364)/2, 44, 364, 706)];
    backgroundImageView.image = [UIImage imageNamed:@"LanguageBackground.png"];
    [containerView addSubview:backgroundImageView];
    
    
    /*判断语言设置为中文的情况*/
//    NSString* strLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    
    
    /*中文简体*/
    
    language_SimplifiedChineseButton = [[BaseButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width/2-100, 70, 250, 59)];
    [language_SimplifiedChineseButton setTag:10001];
    [language_SimplifiedChineseButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    if ([languageString isEqualToString:@"zh-Hans"]) {
        simpleChineseSelected = YES;
        [language_SimplifiedChineseButton setImage:[UIImage imageNamed:@"Language_SimplifiedChinese_Selected.png"] forState:UIControlStateNormal];
    }else{
        simpleChineseSelected = NO;
        [language_SimplifiedChineseButton setImage:[UIImage imageNamed:@"Language_SimplifiedChinese_Normal.png"] forState:UIControlStateNormal];
    }
    
    
    
    /*中文繁体*/
    language_TraditionalChineseButton = [[BaseButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width/2-180, 122, 238, 55)];
    [language_TraditionalChineseButton setTag:10002];
    [language_TraditionalChineseButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([languageString isEqualToString:@"zh-Hant"]) {
        traditionalChineseSelected = YES;
        [language_TraditionalChineseButton setImage:[UIImage imageNamed:@"Language_TraditionalChinese_Selected.png"] forState:UIControlStateNormal];
    }else {
        traditionalChineseSelected = NO;
        [language_TraditionalChineseButton setImage:[UIImage imageNamed:@"Language_TraditionalChinese_Normal.png"] forState:UIControlStateNormal];
    }
    
    
    /*English*/
    language_EnglishButton = [[BaseButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width/2-90, 168, 252, 56)];
    [language_EnglishButton setTag:10003];
    [language_EnglishButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([languageString isEqualToString:@"en"]) {
        englishSelected = YES;
        [language_EnglishButton setImage:[UIImage imageNamed:@"Language_English_Selected.png"] forState:UIControlStateNormal];
    }else {
        englishSelected = NO;
        [language_EnglishButton setImage:[UIImage imageNamed:@"Language_English_Normal.png"] forState:UIControlStateNormal];
    }
    
    /*德语*/
    language_DeutschButton = [[BaseButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width/2-180, 213, 250, 61)];
    [language_DeutschButton setTag:10004];
    [language_DeutschButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    if ([strLanguage isEqualToString:@"de"]) {
//        deutschSelected = YES;
//        [language_DeutschButton setImage:[UIImage imageNamed:@"Language_Deutsch_Selected.png"] forState:UIControlStateNormal];
//    }else {
        deutschSelected = NO;
        [language_DeutschButton setImage:[UIImage imageNamed:@"Language_Deutsch_Normal.png"] forState:UIControlStateNormal];
//    }
    
    /*法语*/
    language_FrenchButton = [[BaseButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width/2-95, 260, 239, 61)];
    [language_FrenchButton setTag:10005];
    [language_FrenchButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    if ([strLanguage isEqualToString:@"de"]) {
//        frenchSelected = YES;
//        [language_FrenchButton setImage:[UIImage imageNamed:@"Language_French_Selected.png"] forState:UIControlStateNormal];
//    }else {
        frenchSelected = NO;
        [language_FrenchButton setImage:[UIImage imageNamed:@"Language_French_Normal.png"] forState:UIControlStateNormal];
//    }
    
    /*意大利语*/
    language_ItalianaButton = [[BaseButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width/2-190, 311, 251, 55)];
    [language_ItalianaButton setTag:10006];
    [language_ItalianaButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    if ([strLanguage isEqualToString:@"it"]) {
//        italianaSelected = YES;
//        [language_ItalianaButton setImage:[UIImage imageNamed:@"Language_Italiana_Selected.png"] forState:UIControlStateNormal];
//    }else {
        italianaSelected = NO;
        [language_ItalianaButton setImage:[UIImage imageNamed:@"Language_Italiana_Normal.png"] forState:UIControlStateNormal];
//    }
    
    /*西班牙语*/
    language_EspanishButton = [[BaseButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width/2-100, 358, 250, 55)];
    [language_EspanishButton setTag:10007];
    [language_EspanishButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    if ([strLanguage isEqualToString:@"es"]) {
//        espanishSelected = YES;
//        [language_EspanishButton setImage:[UIImage imageNamed:@"Language_Espanish_Selected.png"] forState:UIControlStateNormal];
//    }else {
        espanishSelected = NO;
        [language_EspanishButton setImage:[UIImage imageNamed:@"Language_Espanish_Normal.png"] forState:UIControlStateNormal];
//    }
    
    /*俄语*/
    language_pycckNNButton = [[BaseButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width/2-180, 408, 238, 55)];
    [language_pycckNNButton setTag:10008];
    [language_pycckNNButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    if ([strLanguage isEqualToString:@"ru"]) {
//        pycckNNSelected = YES;
//        [language_pycckNNButton setImage:[UIImage imageNamed:@"Language_pycckNN_Selected.png"] forState:UIControlStateNormal];
//    }else {
        pycckNNSelected = NO;
        [language_pycckNNButton setImage:[UIImage imageNamed:@"Language_pycckNN_Normal.png"] forState:UIControlStateNormal];
//    }
    
    /*葡萄牙语*/
    language_PortuguesButton = [[BaseButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width/2-85, 453, 252, 56)];
    [language_PortuguesButton setTag:10009];
    [language_PortuguesButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    if ([strLanguage isEqualToString:@"pl"]) {
//        portuguesSelected = YES;
//        [language_PortuguesButton setImage:[UIImage imageNamed:@"Language_Portugues_Selected.png"] forState:UIControlStateNormal];
//    }else {
        portuguesSelected = NO;
        [language_PortuguesButton setImage:[UIImage imageNamed:@"Language_Portugues_Normal.png"] forState:UIControlStateNormal];
//    }
    
    /*日语*/
    language_JapaneseButton = [[BaseButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width/2-155, 500, 249, 61)];
    [language_JapaneseButton setTag:10010];
    [language_JapaneseButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    if ([strLanguage isEqualToString:@"ja"]) {
//        japaneseSelected = YES;
//        [language_JapaneseButton setImage:[UIImage imageNamed:@"Language_Japanese_Selected.png"] forState:UIControlStateNormal];
//    }else {
        japaneseSelected = NO;
        [language_JapaneseButton setImage:[UIImage imageNamed:@"Language_Japanese_Normal.png"] forState:UIControlStateNormal];
//    }
    
    /*韩语*/
    language_KoreanButton = [[BaseButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width/2-90, 555, 238, 61)];
    [language_KoreanButton setTag:10011];
    [language_KoreanButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    if ([strLanguage isEqualToString:@"ko"]) {
//        koreanSelected = YES;
//        [language_KoreanButton setImage:[UIImage imageNamed:@"Language_Korean_Selected.png"] forState:UIControlStateNormal];
//    }else {
        koreanSelected = NO;
        [language_KoreanButton setImage:[UIImage imageNamed:@"Language_Korean_Normal.png"] forState:UIControlStateNormal];
//    }
    
    /*希伯来语*/
    language_ALBButton = [[BaseButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width/2-190, 608, 251, 55)];
    [language_ALBButton setTag:10012];
    [language_ALBButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    if ([strLanguage isEqualToString:@"he"]) {
//        aLBSelected = YES;
//        [language_ALBButton setImage:[UIImage imageNamed:@"Language_ALB_Selected.png"] forState:UIControlStateNormal];
//    }else {
        aLBSelected = NO;
        [language_ALBButton setImage:[UIImage imageNamed:@"Language_ALB_Normal.png"] forState:UIControlStateNormal];
//    }
    
    [containerView addSubview:language_EnglishButton];
    [containerView addSubview:language_TraditionalChineseButton];
    [containerView addSubview:language_SimplifiedChineseButton];
    [containerView addSubview:language_ItalianaButton];
    [containerView addSubview:language_FrenchButton];
    [containerView addSubview:language_DeutschButton];
    [containerView addSubview:language_EspanishButton];
    [containerView addSubview:language_PortuguesButton];
    [containerView addSubview:language_pycckNNButton];
    [containerView addSubview:language_JapaneseButton];
    [containerView addSubview:language_ALBButton];
    [containerView addSubview:language_KoreanButton];
}

- (void)buttonClicked:(BaseButton *)sender
{
    UIAlertView *alertViewSelect;//选择语言
    
    NSString *simplifiedChinese = @"选择'好的',本软件会跳转至主界面并且进入对应的语言环境!";
    NSString *traditionalChinese = @"選擇’好的‘，本軟件會跳轉至主界面並且進入對應的語言環境！";
    NSString *english = @"Select 'OK', the software will jump to the main screen and enter the corresponding language environment!";
    NSString *deutsch = @"Stay tuned!";
    NSString *french = @"Restez à l'écoute!";
    NSString *italiana = @"Selezionare 'OK', il software passa alla schermata principale e nell'ambiente lingua corrispondente!";
    NSString *espanish = @"Manténgase en sintonía!";
    NSString *pycckNN = @"Оставайтесь с нами!";
    NSString *portugues= @"Fique atento!";
    NSString *japanese = @"お楽しみに!";
    NSString *korean = @"지켜봐!";
    NSString *aLB = @"השארו";
    
    if (sender.tag == 10001) {
        if (simpleChineseSelected) {
            alertViewSelect = [[UIAlertView alloc] initWithTitle:[Config DPLocalizedString:@"Tips"] message:@"当前语言为\"中文简体\",无需重复设置!" delegate:nil cancelButtonTitle:nil otherButtonTitles:[Config DPLocalizedString:@"User_OK"], nil];
            [alertViewSelect show];
            [alertViewSelect release];
        }else {
            alertViewSelect = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsForSimplifiedChinese"],@"语言设定"] message:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsMessageForSimplifiedChinese"],simplifiedChinese] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"User_Cancel"] otherButtonTitles:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_OKForSimplifiedChinese"],@"好的"] , nil];
            alertViewSelect.tag = 1001;
            [alertViewSelect show];
            [alertViewSelect release];
            
            
           
        }
    }else if (sender.tag == 10002){
//        if (traditionalChineseSelected ) {
//            alertViewSelect = [[UIAlertView alloc] initWithTitle:[Config DPLocalizedString:@"Tips"] message:@"當前語言為\"繁體中文\",無需重複設置!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
//            [alertViewSelect show];
//            [alertViewSelect release];
//        }else {
            alertViewSelect = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsForTraditionalChinese"],@"語言設定"] message:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsMessageForTraditionalChinese"],traditionalChinese] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"User_Cancel"] otherButtonTitles:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_OKForTraditionalChinese"],@"好的"] , nil];
            alertViewSelect.tag = 1002;
            [alertViewSelect show];
            [alertViewSelect release];
            
            
            
            //退出程序的方法
//            [self exitApplication];
           
//        }
    }else if (sender.tag == 10003){
        if (englishSelected ) {
            alertViewSelect = [[UIAlertView alloc] initWithTitle:@"Prompt" message:@"Current language is \"English\", no neeed to reset!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertViewSelect show];
            [alertViewSelect release];
        }else {
            alertViewSelect = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsForEnglish"],@"Language Settings"] message:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsMessageForeEnglish"],english] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"User_Cancel"] otherButtonTitles:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_OKForEnglish"],@"OK"] , nil];
            alertViewSelect.tag = 1003;
            [alertViewSelect show];
            [alertViewSelect release];
            
            
        }
    }else if (sender.tag == 10004){
//        if (deutschSelected) {
//            alertViewSelect = [[UIAlertView alloc] initWithTitle:@"Prompt" message:@"Aktuelle Sprache ist \"Deutsche\", muss nicht wiederholt werden!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            [alertViewSelect show];
//            [alertViewSelect release];
//        }else {
            alertViewSelect = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsForDeutsch"],@"Spracheinstellungen"] message:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsMessageForDeutsch"],deutsch] delegate:nil cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_OKForDeutsch"],@"OK"] , nil];
            [alertViewSelect show];
            [alertViewSelect release];
//        }
    }else if (sender.tag == 10005){
//        if (frenchSelected ) {
//            alertViewSelect = [[UIAlertView alloc] initWithTitle:@"Prompt" message:@"Langue en cours est \"Français\", n'a pas besoin d'être répété!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            [alertViewSelect show];
//            [alertViewSelect release];
//        }else {
            alertViewSelect = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsForFrench"],@"Paramètres de langue"] message:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsMessageForFrench"],french] delegate:nil cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_OKForFrench"],@"OK"] , nil];
            [alertViewSelect show];
            [alertViewSelect release];
//        }
    }else if (sender.tag == 10006){
//        if (italianaSelected ) {
//            alertViewSelect = [[UIAlertView alloc] initWithTitle:@"Prompt" message:@"Linguaggio corrente è \"italiano\", non deve essere ripetuta!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            [alertViewSelect show];
//            [alertViewSelect release];
//        }else {
            alertViewSelect = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsForItaliana"],@"Impostazioni della lingua"] message:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsMessageForItaliana"],italiana] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"User_Cancel"] otherButtonTitles:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_OKForItaliana"],@"OK"] , nil];



/*alertViewSelect = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsForTraditionalChinese"],@"語言設定"] message:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsMessageForTraditionalChinese"],traditionalChinese] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"User_Cancel"] otherButtonTitles:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_OKForTraditionalChinese"],@"Good"] , nil];
*/
        alertViewSelect.tag = 1006;
            [alertViewSelect show];
            [alertViewSelect release];
//        }
    }else if (sender.tag == 10007){
//        if (espanishSelected ) {
//            alertViewSelect = [[UIAlertView alloc] initWithTitle:@"Pronto" message:@"Lenguaje actual es \"española\", no será necesario repetir!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Bueno", nil];
//            [alertViewSelect show];
//            [alertViewSelect release];
//        }else {
            alertViewSelect = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsForEspanish"],@"Configuración de idioma"] message:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsMessageForEspanish"],espanish] delegate:nil cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_OKForEspanish"],@"bueno"] , nil];
            [alertViewSelect show];
            [alertViewSelect release];
//        }
    }else if (sender.tag == 10008){
//        if (pycckNNSelected ) {
//            alertViewSelect = [[UIAlertView alloc] initWithTitle:@"побуждать" message:@"Текущий язык \"русский\", можно не повторять!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Xорошо", nil];
//            [alertViewSelect show];
//            [alertViewSelect release];
//        }else {
        alertViewSelect = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsForPycckNN"],@"Настройки языка"] message:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsMessageForPycckNN"],pycckNN] delegate:nil cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_OKForPycckNN"],@"хорошо"] , nil];
            [alertViewSelect show];
            [alertViewSelect release];
          
//        }
    }else if (sender.tag == 10009){
//        if (portuguesSelected ) {
//            alertViewSelect = [[UIAlertView alloc] initWithTitle:@"Incitar" message:@"Idioma atual é \"Português\", não precisa ser repetido!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            [alertViewSelect show];
//            [alertViewSelect release];
//        }else {
            alertViewSelect = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsForPortugues"],@"Configurações de Idioma"] message:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsMessageForPortugues"],portugues] delegate:nil cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_OKForPortugues"],@"OK"] , nil];
            [alertViewSelect show];
            [alertViewSelect release];
//        }
    }else if (sender.tag == 10010){
//        if (japaneseSelected ) {
//            alertViewSelect = [[UIAlertView alloc] initWithTitle:@"プロンプト" message:@"現在の言語は、\"日本人\"で繰り返される必要はありません！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"グッド", nil];
//            [alertViewSelect show];
//            [alertViewSelect release];
//        }else {
        alertViewSelect = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsForJapanese"],@"言語設定"] message:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsMessageForJapanese"],japanese] delegate:nil cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_OKForJapanese"],@"OK"] , nil];
            [alertViewSelect show];
            [alertViewSelect release];
//        }
    }else if (sender.tag == 10011){
//        if (koreanSelected ) {
//            alertViewSelect = [[UIAlertView alloc] initWithTitle:@"프롬프트" message:@"현재 언어는  \"한국\"필요하지 반복!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"좋은", nil];
//            [alertViewSelect show];
//            [alertViewSelect release];
//        }else {
        alertViewSelect = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsForKorean"],@"언어 설정"] message:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsMessageForKorean"],korean] delegate:nil cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_OKForKorean"],@"OK"] , nil];
            [alertViewSelect show];
            [alertViewSelect release];
//        }
    }else if (sender.tag == 10012){
//        if (aLBSelected ) {
//            alertViewSelect = [[UIAlertView alloc] initWithTitle:@"להניע" message:@"שפה נוכחית היא \"עברית\", לא צריך להיות חוזר ונשנה!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"טוב", nil];
//            [alertViewSelect show];
//            [alertViewSelect release];
//        }else {
        alertViewSelect = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsForALB"],@"הגדרות שפה"] message:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_LanguageSettingsMessageForALB"],aLB] delegate:nil cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:[Config DPLocalizedString:@"Language_OKForALB"],@"אישור"] , nil];
        [alertViewSelect show];
        [alertViewSelect release];
//        }
    }
}

//-------------------------------- 退出程序 -----------------------------------------//

- (void)exitApplication {
    
    UIWindow* window=[(AppDelegate*)[[UIApplication sharedApplication]delegate]window];
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:containerView.window cache:NO];
    
    [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    //containerView.window.bounds = CGRectMake(0, 0, 0, 0);
    
    window.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
    
}



- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
        
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        if (alertView.tag == 1001) {
            languageString = @"zh-Hans";
            NSUserDefaults * language1 = [NSUserDefaults standardUserDefaults];
            [language1 setObject:languageString forKey:LOCAL_LANGUAGE];
        }
        else if (alertView.tag == 1002){
            languageString = @"zh-Hant";
            NSUserDefaults * language1 = [NSUserDefaults standardUserDefaults];
            [language1 setObject:languageString forKey:LOCAL_LANGUAGE];
        }
        else if (alertView.tag == 1003){
            languageString = @"en";
            NSUserDefaults * language1 = [NSUserDefaults standardUserDefaults];
            [language1 setObject:languageString forKey:LOCAL_LANGUAGE];
        }else if (alertView.tag == 1006){
            languageString = @"it";
            NSUserDefaults * language1 = [NSUserDefaults standardUserDefaults];
            [language1 setObject:languageString forKey:LOCAL_LANGUAGE];
        }
        
        splitVCDemoViewController = [[SplitVCDemoViewController alloc] initWithNibName:@"SplitVCDemoViewController" bundle:nil];
        UIWindow* window=[(AppDelegate*)[[UIApplication sharedApplication]delegate]window];
        window.rootViewController = ((UIViewController*)splitVCDemoViewController);
        
        
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
