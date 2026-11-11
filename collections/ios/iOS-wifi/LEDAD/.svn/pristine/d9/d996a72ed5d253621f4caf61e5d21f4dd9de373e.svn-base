//
//  DYT_nearscreentableview.m
//  LEDAD
//
//  Created by laidiya on 15/7/30.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_nearscreentableview.h"


#import "LayoutYXMViewController.h"
#import "XMLDictionary.h"
#import "Project.h"
@implementation DYT_nearscreentableview
{

    
    NSMutableArray *_gruoparray;

}
-(id)initWithFrame:(CGRect)frame andtag:(NSInteger)tag;
{

    
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.tag = tag;
        _gruoparray = [[NSMutableArray alloc]init];
        [self getbendi];
    }
    
    return self;

    

}

-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        _gruoparray = [[NSMutableArray alloc]init];
        [self getbendi];
    }
    
    return self;


}
-(void)getbendi
{

    //保存到数据里面
    NSUserDefaults *mysqlarray = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *array = [mysqlarray objectForKey:@"mysqlprojects"];
    
   
    
    
   
    
    
    DLog(@"得到数据-------%lu    %d",(unsigned long)array.count ,self.tag );
    
    for (int i=0; i<array.count; i++) {
        NSMutableDictionary *dic = array[i];
        
        Group   *my_friendsData = [[Group alloc]init];
        my_friendsData.Grouping_Name = [dic objectForKey:@"name"];
        my_friendsData.qcheck = NO;
        
        if (self.tag==9000) {
             NSMutableArray *mypro =[[NSMutableArray alloc]init];
                    for (NSString *str in [dic objectForKey:@"myproject"]) {
                        Project *pro = [[Project alloc]init];
                        pro.qchexk = NO;
                        pro.Material_Name = str;
                        NSLog(@"段雨田 ＝＝＝＝＝%@",str);
            
                        [mypro addObject:pro];
                    }
        my_friendsData.Materials = mypro;
            
        }else
        {
          my_friendsData.Materials = dic[@"myproject"];
            
        }
        
        
        [_gruoparray addObject:my_friendsData];
        
    }
    
    [self reloadData];
    
    

}

#pragma mark-TABLE

//设置段头长
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    //    查看项目
    if (tableView.tag==1001) {
        
        return 0;
    }
    else
    {
        //        1002 添加项目
        return 44;
    }
}

//返回多少段 Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    if (tableView.tag==1001) {
        //
        return 1;
    }else
    {
        
        //        分组信息
        
        
        
        return _gruoparray.count;
        
    }
}

//设置段头
-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    if (tableView.tag==1001) {
        return nil;
    }else
    {
        HeadView *headView = [HeadView headViewWithTableView:tableView];
        
        headView.mytag = section+3000;
        Group *gg = _gruoparray[section];
        headView.delegate = self;
        headView.qchek = gg.qcheck;
        headView.group = gg;
        
        
        return headView;
        
    }
    
    
}

#pragma mark-段头

//点击展开或收
- (void)clickHeadView:(NSInteger)tag;
{
    [self reloadData];
    
}

//选择框 段头
-(void)chooseview:(NSInteger)tag andchoose:(BOOL)chex;
{
    
    
    
    Group *gg = _gruoparray[tag-3000];
    
    
    DLog(@"====%d",gg.Materials.count);
//    //    HeadView *head = (HeadView *)[self.view viewWithTag:tag];
    DLog(@"====%d    %d",self.count,chex);
    
    
    
    
    
    
    if ((gg.Materials.count<self.count && chex==YES&&self.tag==8000)||self.count==0) {
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"项目少于屏" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [aler show];
        
        gg.qcheck = NO;
        
         [self reloadData];
        return;
        
        
    }
    
//    段头   添加分组
    if (self.tag == 8000) {
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (int i=0; i<gg.Materials.count; i++) {
         ProjectListObject *myPro = [self findmyproject:gg.Materials[i]];
            [array addObject:myPro];
          
            
        }
        
        gg.qcheck = chex;
        
        [self.mydelegate selectproject:array andqchex:chex];
        [self reloadData];
        return;
    }
    
    
//    选组 和选单个
    if (self.tag==9000) {
        
         gg.qcheck = chex;
        
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        for (int i=0; i<gg.Materials.count; i++) {
            Project *pro = gg.Materials[i];
             ProjectListObject *myPro = [self findmyproject:pro.Material_Name];
            if (chex==YES) {
                if (pro.qchexk==YES) {
                    
                }else
                {
                    pro.qchexk = YES;
                    [array addObject:myPro];
                }
                
                
            }else{
            
//            选择的是否
               
                pro.qchexk = NO;
                [array addObject:myPro];
            }
            
        
        }
        
        
        
        
//
        [self reloadData];
//
        [self.mydelegate selectproject:array andqchex:chex];
       
        return;

        
        
    }

    
    
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    //            NSString *Material_Name  = group.Materials[indexPath.row];
    for (int i=0; i<gg.Materials.count; i++) {
         ProjectListObject *myPro = [self findmyproject:gg.Materials[i]];
        [array addObject:myPro];
    }
    
//    ProjectListObject *myPro = [self findmyproject:group.Materials[indexPath.row]];

    
//    1001
    if (_mydelegate &&[_mydelegate respondsToSelector:@selector(selectproject:)]) {
        [_mydelegate selectproject:array];
    }
   
    
    
    
    
    
}

//设置 多少cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1001) {
        
        return _gruoparray.count;
    }else
    {
        
        Group *group = _gruoparray[section];
        NSInteger count = group.isOpened ? group.Materials.count : 0;
        return count;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    if (tableView.tag==9000)
    {
        
        
        static NSString *cellReuseIdentifierString = @"mylookcell";
        //        查看项目
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifierString];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifierString];
        }
        
        
        Group *group = _gruoparray[indexPath.section];
        
        Project *pro = group.Materials[indexPath.row];
        
        DLog(@"====%d",pro.qchexk);
        
        ProjectListObject *myPro = [self findmyproject:pro.Material_Name];
        
        cell.textLabel.text = myPro.project_name;
        
       
        
        

        
        UIButton *qchekbutton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-35, 0, 30, 30)];
        [qchekbutton setBackgroundImage:[UIImage imageNamed:@"checkbox1_unchecked@2x"] forState:UIControlStateNormal];
        [qchekbutton setBackgroundImage:[UIImage imageNamed:@"checkbox1_checked@2x"] forState:UIControlStateSelected];
        qchekbutton.tag = 10000*(indexPath.section+1)+indexPath.row;
        [qchekbutton addTarget:self action:@selector(cellsendproject:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:qchekbutton];
        
        if (group.qcheck == YES) {
            
            qchekbutton.selected = YES;
        }
        if (pro.qchexk ==YES) {
            
            qchekbutton.selected = YES;
        }
        
        
        
         return cell;
        
        
    }else{
    
        
        
        static NSString *cellReuseIdentifierString = @"mylookcell";
        //        查看项目
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifierString];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifierString];
        }
        
        Group *group = _gruoparray[indexPath.section];
        
        
        
        
        ProjectListObject *myPro = [self findmyproject:group.Materials[indexPath.row]];
        
        cell.textLabel.text = myPro.project_name;
        
        return cell;
        
        

        
    
    
    
    
    }

    
    
        
        
    
    
}


//单击  选择项目
-(void)cellsendproject:(UIButton *)sender
{

    
    NSInteger section = sender.tag/10000-1;
    NSInteger row = sender.tag%10000;
    
    
    
    
    sender.selected = !sender.selected;
    
    
    
    Group *group = _gruoparray[section];
    
    
    
    Project *pro = group.Materials[row];
    
    pro.qchexk = sender.selected;
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:group.Materials];
    
    [array replaceObjectAtIndex:row withObject:pro];
    
    
    group.Materials  = array;
    
    [_gruoparray replaceObjectAtIndex:section withObject:group];
    
    ProjectListObject *myPro = [self findmyproject:pro.Material_Name];
    
    
    
    
    NSMutableArray *arr = [[NSMutableArray alloc]initWithObjects:myPro, nil];
    
    if (self.mydelegate &&[self.mydelegate respondsToSelector:@selector(selectproject:andqchex:)]) {
        
        [self.mydelegate selectproject:arr andqchex:sender.selected];

    }
    
    [self reloadData];

}




//判断我要的东西 获取素材

-(ProjectListObject *)findmyproject:(NSString *)mypath
{
    
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/"];
    filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
                                                       fromDirPath:documentsDirectory AndIsGroupDir:NO];
    NSInteger count = filenameArray.count;
    
    for (int i=0; i<count; i++) {
        NSString *path = [NSString stringWithFormat:@"%@",[[filenameArray objectAtIndex:i] lastPathComponent]];
        if ([path isEqualToString:mypath]) {
            
            ProjectListObject *myPro = [[ProjectListObject alloc]init];
            [self getProjectNameWithFileName:[filenameArray objectAtIndex:i] andProjectObj:myPro];
            return myPro;
        }
    }
    
    return nil;
}


-(void)getProjectNameWithFileName:(NSString *)myFilePath andProjectObj:(ProjectListObject*)myProjectObj{
    @try {
        DLog(@"dataDictionary.filePath = %@",myFilePath);
        NSDictionary *dataDictionary = [NSDictionary dictionaryWithXMLFile:myFilePath];
        DLog(@"dataDictionary 字典-----------------= %@",dataDictionary);
        NSString *projectName = nil;
        BOOL includeMusic = NO;
        
        //        BOOL isExsit=NO;//默认不存在
        
        
        if (dataDictionary) {
            if ([dataDictionary objectForKey:@"projectName"]) {
                projectName = [[NSString alloc]initWithString:[dataDictionary objectForKey:@"projectName"]];
                DLog(@"****________________****%@",projectName);
                
                //                if ([projectName rangeOfString:@"h"].location !=NSNotFound) {
                //                    isExsit=YES;
                //                }
                
            }
            if ([[dataDictionary objectForKey:@"projectMusicElement"] isKindOfClass:[NSDictionary class]]) {
                includeMusic = YES;
            }
            //判断是否存在这标识符
            
            
        }
        
        [myProjectObj setProject_filename:myFilePath];
        [myProjectObj setProject_name:projectName];
        [myProjectObj setProject_list_type:IS_PROJECT_XML];
        [myProjectObj setIsIncludeMusic:includeMusic];
        
        //存在
        //       [myProjectObj setIsExist:isExsit];
        
        [myProjectObj setIsSelected:NO];
    }
    @catch (NSException *exception) {
        DLog(@"解析项目名称异常 = %@",exception);
    }
    @finally {
    }
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
