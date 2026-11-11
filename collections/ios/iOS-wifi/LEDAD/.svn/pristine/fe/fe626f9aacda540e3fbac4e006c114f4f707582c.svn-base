//
//  DYT_gourptableview.m
//  LEDAD
//  添加素材 查看素材
//  Created by laidiya on 15/7/24.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_gourptableview.h"
#import "Group.h"
#import "ProjectListObject.h"
#import "Project.h"
#import "LayoutYXMViewController.h"
#import "XMLDictionary.h"
#import "Config.h"
@implementation DYT_gourptableview

-(id)initWithFrame:(CGRect)frame andtag:(NSInteger)tag
{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.tag = tag;
        [self _settitle];
        
        self.grouparray = [[NSMutableArray alloc]init];
        
        if (tag==1) {
            
            [self lookview];
        }else{
        
            [self addview];
        }
        
    }
    return self;
    

}

-(void)_settitle
{

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = [Config DPLocalizedString:@"adedit_Item"];
    [self addSubview:title];
    
    UIButton *backbutt = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [backbutt setBackgroundImage:[UIImage imageNamed:@"dyt_back"] forState:UIControlStateNormal];
    [backbutt addTarget:self action:@selector(tablecancel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backbutt];
    
    UIButton *makebutton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-35, 5, 30, 30)];
    [makebutton addTarget:self action:@selector(makesure:) forControlEvents:UIControlEventTouchUpInside];
    [makebutton setImage:[UIImage imageNamed:@"gg"] forState:0];
    [self addSubview:makebutton];
    if (self.tag==1) {
        title.text = [Config DPLocalizedString:@"adedit_ck"];
        makebutton.hidden = YES;
    }
    
    self.namelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, 30)];
    self.namelabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.namelabel];
    
    UIImageView *headview = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-20, self.namelabel.frame.origin.y+30, 40, 40)];
    headview.image = [UIImage imageNamed:@"LEDYES"];
    
    [self addSubview:headview];
    
    
    
    _mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0, headview.frame.origin.y+45, self.frame.size.width, self.frame.size.height-_mytableview.frame.origin.y)];
    _mytableview.dataSource = self;
    _mytableview.delegate  = self;
    _mytableview.tag = self.tag+1000;
    [self addSubview:_mytableview];
    
    
    
    
    
    
}

-(void)tablecancel:(UIButton *)sender
{
   
     self.cancel(@"0");

}
-(void)makesure:(UIButton *)sender
{
    
    NSMutableArray *addarray = [[NSMutableArray alloc]init];
    
    for (int i=0; i<self.grouparray.count; i++) {
        Group *grop = self.grouparray[i];
        
        for (int k=0; k<grop.Materials.count; k++) {
             Project *project = grop.Materials[k];
            if (project.qchexk==YES) {
                [addarray addObject:project.Material_Name];
            }
            
        }
       
        
        
    }
    
     _addpro(addarray);
   

}

-(void)replayview:(NSArray *)array;
{

    if (self.tag==1) {
        [self.grouparray removeAllObjects];

        [self.grouparray addObjectsFromArray:array];
        
    }else
    {
    
        //保存到数据里面
        NSUserDefaults *mysqlarray = [NSUserDefaults standardUserDefaults];
        
        NSMutableArray *array = [mysqlarray objectForKey:@"mysqlprojects"];

        [self.grouparray removeAllObjects];
        
        
        for (int i=0; i<array.count; i++) {
            NSMutableDictionary *dic = array[i];
            
            Group   *my_friendsData = [[Group alloc]init];
            
            my_friendsData.Grouping_Name = [dic objectForKey:@"name"];
            my_friendsData.qcheck = NO;
            NSMutableArray *mypro =[[NSMutableArray alloc]init];
            
            for (NSString *str in [dic objectForKey:@"myproject"]) {
                Project *pro = [[Project alloc]init];
                pro.qchexk = NO;
                pro.Material_Name = str;
                NSLog(@"段雨田 ＝＝＝＝＝%@",str);

                [mypro addObject:pro];
            }
            
            
            my_friendsData.Materials = mypro;
            
            [self.grouparray addObject:my_friendsData];
            
        }

        
    
    
    }
    
    
    [_mytableview reloadData];

}


//查看项目
-(void)lookview
{
    
   
    

    
    
    
    
}


//添加项目
-(void)addview
{

    

    
    
    
    
}


#pragma mark-TABLE


//设置段头长
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
//    查看项目
    if (tableView.tag==1001) {
        
        return 0;
    }else
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
        
        
        
    return self.grouparray.count;
        
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
        Group *gg = self.grouparray[section];
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
    [_mytableview reloadData];

}


//选择框
-(void)chooseview:(NSInteger)tag andchoose:(BOOL)chex;
{
    DLog(@"====%d",tag);
    //    HeadView *head = (HeadView *)[self.view viewWithTag:tag];
    Group *gg = self.grouparray[tag-3000];
    gg.qcheck = chex;

    for (Project *pro in gg.Materials) {
        pro.qchexk = chex;
    }
    [_mytableview reloadData];
    
    
    


}

//设置 多少cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        if (tableView.tag==1001) {
    
        return self.grouparray.count;
        }else
        {
        
            Group *group = self.grouparray[section];
            NSInteger count = group.isOpened ? group.Materials.count : 0;
            return count;
           }
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
    
    
}

#pragma mark-返回编辑模式'
//返回编辑状态的style
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DLog(@"===%d",tableView.tag);
    if (tableView.tag==1001) {
        
        return UITableViewCellEditingStyleDelete;
        
    }else{
        
        return UITableViewCellEditingStyleNone;
    }
}


//完成编辑的触发事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        
        [self.grouparray removeObjectAtIndex:indexPath.row];
        [_mytableview reloadData];
        
        
        _addpro(self.grouparray);
        
        
        
        
    }
}


//修改文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [Config DPLocalizedString:@"adedit_musicdelbutton"];
   
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView.tag==1001) {
        static NSString *cellReuseIdentifierString = @"mylookcell";
//        查看项目
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifierString];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifierString];
        }
        DLog(@"？？？？？？=====%@",self.grouparray);
        
         ProjectListObject *myPro = [self findmyproject:self.grouparray[indexPath.row]];
        DLog(@"??==%@",myPro.project_name);
        cell.textLabel.text = myPro.project_name;
        return cell;
        
        
        
        
    }else
    {
    
        static NSString *cellReuseIdentifierString = @"myaddcell";

        
        //        添加项目
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifierString];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifierString];
        }
        [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];//删除子视图防止重叠

        
        Group *group = self.grouparray[indexPath.section];
        
        
        Project *project = group.Materials[indexPath.row];
        
        DLog(@"===%@",project.Material_Name);
        
        
        
        ProjectListObject *myPro = [self findmyproject:project.Material_Name];
        
        
        NSLog(@"%@",myPro.project_name);
        
        UIButton *upbutton = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width-50, 2, 30, 30)];
        
        [upbutton setBackgroundImage:[UIImage imageNamed:@"李文涛丑"] forState:UIControlStateNormal];
        [upbutton setBackgroundImage:[UIImage imageNamed:@"选中框"] forState:UIControlStateSelected];
        
//        [upbutton setImage:[UIImage imageNamed:@"upload"] forState:UIControlStateNormal];
        [upbutton addTarget:self action:@selector(cellupbuttonchoose:) forControlEvents:UIControlEventTouchUpInside];
        upbutton.tag = 20000*indexPath.section+indexPath.row+1;
        [cell.contentView addSubview:upbutton];
        
        if (group.qcheck==YES) {
             upbutton.selected = group.qcheck;
        }else
        {
        
            upbutton.selected = project.qchexk;
            
        }
        
       
        
        cell.textLabel.text = myPro.project_name;
        cell.backgroundColor = [UIColor whiteColor];
       
        
        return cell;

        
        
    
    
    
    }
 
}





-(void)cellupbuttonchoose:(UIButton *)sender
{

    sender.selected = !sender.selected;
    
    NSInteger section = sender.tag/20000;
    NSInteger row = sender.tag%20000-1;

    DLog(@"==%d",row);
    Group *group = self.grouparray[section];
     Project *project = group.Materials[row];
    project.qchexk = sender.selected;
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
