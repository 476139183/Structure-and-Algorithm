//
//  PushViewController.m
//  ZDEC
//
//  Created by LDY on 13-9-9.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import "PushViewController.h"
#import "PushDetailViewController.h"
#import "MyToolBar.h"
#import "Config.h"
#import "DataItems.h"




#import "JsonToObjectAdapter.h"

#import "Config.h"
#import "MyFriendListJTOA.h"
#import "PushMyFriendsCell.h"
#import "MyTool.h"

@interface PushViewController ()

@end

@implementation PushViewController
@synthesize keyString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithItem:(DataItems*)item
{
    if (self) {
        self.title = @"列表";
        
        
        if (salesMutableArray == nil) {
            salesMutableArray = [[NSMutableArray alloc]initWithCapacity:1];
        }
        if (filterDataArray == nil) {
            filterDataArray = [[NSMutableArray alloc]initWithCapacity:1];
        }
        
        [self sendAsynchronous];
        salerOfCustomerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_CGSIZE_WIDTH,SCREEN_CGSIZE_HEIGHT-20-44) style:UITableViewStylePlain];
        salerOfCustomerTableView.delegate = self;
        salerOfCustomerTableView.dataSource = self;
        [self.view addSubview:salerOfCustomerTableView];
        
        [self.view addSubview:filterCompanyButton];
        [self.view addSubview:filterPositionButton];
        
//        menuItems1 = [[NSMutableArray alloc]initWithCapacity:1];
//        menuItems2 = [[NSMutableArray alloc]initWithCapacity:1];
//        
        toolbar=[[MyToolBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, Config.currentNavigateHeight)];
        UIBarButtonItem *leftbarbtn=[[UIBarButtonItem alloc]
                                     initWithImage:[UIImage imageNamed:@"backitem.png"]
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(SystembackMainSettingView)];
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = 200;
        
        //    UIBarButtonItem *rightbarbtn=[[UIBarButtonItem alloc]
        //                                  initWithImage:[UIImage imageNamed:@"backitem.png"]
        //                                  style:UIBarButtonItemStylePlain
        //                                  target:self
        //                                  action:@selector(confirmButton:)];
        UIBarButtonItem *rightbarbtn=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirmButton:)];
        
        NSMutableArray *myToolBarItems = [[NSMutableArray alloc]initWithObjects:leftbarbtn,space,rightbarbtn,nil ];
        [toolbar setItems:myToolBarItems animated:YES];
        [self.view addSubview:toolbar];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        shareItem = item;
    }
    return self;
}


- (void) SystembackMainSettingView
{
    [[self.navigationController popViewControllerAnimated:YES]retain];
}

//点击确定按钮
- (void)confirmButton:(id)sender
{
    DLog(@"%@",filterDataArray);
    PushDetailViewController *pDetailViewController = [[PushDetailViewController alloc] initWithItem:shareItem andContactItem:filterDataArray];
    [self.navigationController pushViewController:pDetailViewController animated:YES];
    [pDetailViewController release];
    
}



-(void)requestFailed:(ASIHTTPRequest *)request{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    //复选框通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCheckBox:) name:NOTI_CHECK_BOX object:nil];
}

//获得复选框选择的人
-(void)changeCheckBox:(NSNotification*)noti{
    DLog(@"%@",noti);
    NSDictionary *userinfo = [noti userInfo];
    NSString *ischecked = [userinfo objectForKey:@"ischecked"];
    NSString *user_id = [userinfo objectForKey:@"user_id"];
    if ([ischecked isEqualToString:@"1"]) {
        for (UserInfoEntity *oneUserinfo in salesMutableArray) {
            if ([oneUserinfo.user_sid isEqualToString:user_id]) {
                [filterDataArray addObject:oneUserinfo];
            }
        }
    }
    if ([ischecked isEqualToString:@"0"]) {
        for (UserInfoEntity *oneUserinfo in salesMutableArray) {
            if ([oneUserinfo.user_sid isEqualToString:user_id]) {
                [filterDataArray removeObject:oneUserinfo];
            }
        }
    }
}
//-(void)getmenuItems1{
//    //    NSMutableArray *filterArray = [[NSMutableArray alloc]initWithCapacity:1];
//    //    for (CustomeEntity *oneCus in salesMutableArray) {
//    //        NSDictionary *tempDict = [[NSDictionary alloc]initWithObjectsAndKeys:oneCus.cus_company,@"cus_company",oneCus.cus_position,@"cus_position",nil];
//    //        [filterArray addObject:tempDict];
//    //    }
//    //    NSSet *companySet = [[NSSet alloc]init];
//    NSMutableSet *companySet = [[NSMutableSet alloc]initWithCapacity:0];
//    NSMutableSet *positionSet = [[NSMutableSet alloc]initWithCapacity:0];
//    for (int i=0; i<[salesMutableArray count]; i++) {
//        CustomeEntity *ecus = [salesMutableArray objectAtIndex:i];
//        if ([ecus.cus_company length]!=0) {
//            [companySet addObject:ecus.cus_company];
//        }
//        if ([ecus.cus_position length]!=0) {
//            [positionSet addObject:ecus.cus_position];
//        }
//    }
//    //设置公司菜单
//    KxMenuItem *oneMenu1 = [KxMenuItem menuItem:@"不限"
//                                          image:nil
//                                      senderTag:TAG_TOOL_BAR_BUTTON_COMPANY
//                                      parameter:@"不限"
//                                         target:self
//                                         action:@selector(pushMenuItem:)];
//    [menuItems1 addObject:oneMenu1];
//    for (NSString *oneCompany in companySet) {
//        KxMenuItem *oneMenu2 = [KxMenuItem menuItem:oneCompany
//                                              image:nil
//                                          senderTag:TAG_TOOL_BAR_BUTTON_COMPANY
//                                          parameter:oneCompany
//                                             target:self
//                                             action:@selector(pushMenuItem:)];
//        [menuItems1 addObject:oneMenu2];
//    }
//    
//    //设置职位菜单
//    KxMenuItem *oneMenu3 = [KxMenuItem menuItem:@"不限"
//                                          image:nil
//                                      senderTag:TAG_TOOL_BAR_BUTTON_POSITION
//                                      parameter:@"不限"
//                                         target:self
//                                         action:@selector(pushMenuItem:)];
//    [menuItems2 addObject:oneMenu3];
//    for (NSString *onePosition in positionSet) {
//        KxMenuItem *oneMenu4 = [KxMenuItem menuItem:onePosition
//                                              image:nil
//                                          senderTag:TAG_TOOL_BAR_BUTTON_POSITION
//                                          parameter:onePosition
//                                             target:self
//                                             action:@selector(pushMenuItem:)];
//        [menuItems2 addObject:oneMenu4];
//    }
//}

//- (void) pushMenuItem:(KxMenuItem*)sender
//{
//    UIButton *modifyButton = (UIButton*)[self.view viewWithTag:sender.senderTag];
//    //公司筛选条件
//    if (modifyButton.tag==TAG_TOOL_BAR_BUTTON_COMPANY) {
//        filterCompanyStr = sender.parameter;
//        [modifyButton setTitle:filterCompanyStr forState:UIControlStateNormal];
//    }
//    //职位筛选条件
//    if (modifyButton.tag==TAG_TOOL_BAR_BUTTON_POSITION) {
//        filterPositionStr = sender.parameter;
//        [modifyButton setTitle:filterPositionStr forState:UIControlStateNormal];
//    }
//    
//    [self frefreshData:filterCompanyStr position:filterPositionStr];
//}

//-(void)frefreshData:(NSString *)filterCompany position:(NSString*)filterPosition{
//    if ([filterCompanyStr isEqualToString:@"不限"]&&(filterPositionStr==nil)) {
//        //公司选择了不限，职位未选
//        [filterDataArray removeAllObjects];
//        [filterDataArray addObjectsFromArray:salesMutableArray];
//    }else if ([filterPositionStr isEqualToString:@"不限"]&&(filterCompanyStr==nil)) {
//        //职位选择了不限，公司未选
//        [filterDataArray removeAllObjects];
//        [filterDataArray addObjectsFromArray:salesMutableArray];
//    }else if ([filterPositionStr isEqualToString:@"不限"] && [filterCompanyStr isEqualToString:@"不限"]) {
//        //职位选择了不限，公司选择了不限
//        [filterDataArray removeAllObjects];
//        [filterDataArray addObjectsFromArray:salesMutableArray];
//    }else if((![filterPositionStr isEqualToString:@"不限"] && ![filterCompanyStr isEqualToString:@"不限"])&&(([filterPositionStr length]>0) && ([filterCompanyStr length]>0))){
//        [filterDataArray removeAllObjects];
//        //职位选择了某个职位，公司选择了某个公司
//        for (CustomeEntity *oneCus in salesMutableArray) {
//            if ([oneCus.cus_position isEqualToString:filterPositionStr]&&[oneCus.cus_company isEqualToString:filterCompanyStr]) {
//                [filterDataArray addObject:oneCus];
//            }
//        }
//    }else if((![filterPositionStr isEqualToString:@"不限"] && ![filterCompanyStr isEqualToString:@"不限"])&&(([filterPositionStr length]>0) && ([filterCompanyStr length]==0))){
//        [filterDataArray removeAllObjects];
//        //职位选择了某个职位，公司未选
//        for (CustomeEntity *oneCus in salesMutableArray) {
//            if ([oneCus.cus_position isEqualToString:filterPositionStr]) {
//                [filterDataArray addObject:oneCus];
//            }
//        }
//    }else if((![filterPositionStr isEqualToString:@"不限"] && ![filterCompanyStr isEqualToString:@"不限"])&&(([filterPositionStr length]==0) && ([filterCompanyStr length]>0))){
//        [filterDataArray removeAllObjects];
//        //职位未选，公司选择了某个公司
//        for (CustomeEntity *oneCus in salesMutableArray) {
//            if ([oneCus.cus_company isEqualToString:filterCompanyStr]) {
//                [filterDataArray addObject:oneCus];
//            }
//        }
//    }else if(([filterPositionStr isEqualToString:@"不限"] && (![filterCompanyStr isEqualToString:@"不限"]) && ([filterCompanyStr length]>0))){
//        [filterDataArray removeAllObjects];
//        //职位选不限，公司选择了某个公司
//        for (CustomeEntity *oneCus in salesMutableArray) {
//            if ([oneCus.cus_company isEqualToString:filterCompanyStr]) {
//                [filterDataArray addObject:oneCus];
//            }
//        }
//    }else if(([filterCompanyStr isEqualToString:@"不限"] && (![filterPositionStr isEqualToString:@"不限"]) && ([filterPositionStr length]>0))){
//        [filterDataArray removeAllObjects];
//        //职位选某个职位，公司选择了不限
//        for (CustomeEntity *oneCus in salesMutableArray) {
//            if ([oneCus.cus_position isEqualToString:filterPositionStr]) {
//                [filterDataArray addObject:oneCus];
//            }
//        }
//    }
//    
//    [salerOfCustomerTableView reloadData];
//}

//-(void)filterButtonClicked:(UIButton*)sender{
//    
//    if (sender.tag==TAG_TOOL_BAR_BUTTON_COMPANY) {
//        
//        [KxMenu showMenuInView:self.view
//                      fromRect:sender.frame
//                     menuItems:menuItems1];
//    }
//    if (sender.tag==TAG_TOOL_BAR_BUTTON_POSITION) {
//        
//        [KxMenu showMenuInView:self.view
//                      fromRect:sender.frame
//                     menuItems:menuItems2];
//    }
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [salesMutableArray count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([salesMutableArray isKindOfClass:[NSMutableArray class]]) {
        if ([salesMutableArray count]>0) {
            UserInfoEntity *oneUser = [salesMutableArray objectAtIndex:indexPath.row];
            
            DLog(@"oneUser.user_name=%@",oneUser.user_name);
            NSString *cellIndentifier = [[NSString alloc]initWithFormat:@"salecell%d",indexPath.row];
            PushMyFriendsCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if(myCell==nil){
                myCell = [[PushMyFriendsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            if (oneUser==nil) {
                return nil;
            }
            [myCell setEcus:oneUser];
            return myCell;
        }
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([filterDataArray isKindOfClass:[NSMutableArray class]]) {
//        if ([filterDataArray count]>0) {
//            CustomeEntity *ecus = [filterDataArray objectAtIndex:indexPath.row];
//            detailInfoViewController = [[SalerMyCustomerDetailInfoShowViewController alloc] init];
//            [detailInfoViewController setOneCus:ecus];
//            [self.navigationController pushViewController:detailInfoViewController animated:YES];
//            [detailInfoViewController release];
//        }
//    }
    
//    if ([salesMutableArray isKindOfClass:[NSMutableArray class]]) {
//        if ([salesMutableArray count]>0) {
//            CustomeEntity *ecus = [salesMutableArray objectAtIndex:indexPath.row];
//            pushDetailViewController = [[PushDetailViewController alloc] initWithItem:shareItem andContactItem:ecus];
//            [pushDetailViewController setOneCus:ecus];
//            [self.navigationController pushViewController:pushDetailViewController animated:YES];
//            [pushDetailViewController release];
//        }
//    }

    
}


@end
