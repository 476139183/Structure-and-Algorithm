//
//  screendata_TableViewController.m
//  LEDAD
//
//  Created by laidiya on 15/6/25.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "screendata_TableViewController.h"

@interface screendata_TableViewController ()
{

    UIView *firstview;
    UIView *Secondview;
    UIView *Thirdview;
    UIView *Fourthview;
    UIView *Fifthview;
    UIView *Sixthview;




}
@end

@implementation screendata_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.scrollEnabled =NO; //设置tableview 不能滚动
    self.tableView.layer.masksToBounds = YES;
    self.tableView.layer.cornerRadius = 0.6;
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    
    
    [self setfristview];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)setfristview
{
    
    firstview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 80)];
    firstview.backgroundColor = [UIColor redColor];
    
    UIButton *suerbutton = [[UIButton alloc]initWithFrame:CGRectMake(firstview.frame.size.width-50, 0, 50, 50)];
    [suerbutton setTitle:@"确定" forState:UIControlStateNormal];
    [suerbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [firstview addSubview:suerbutton];

    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *infor = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infor];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infor];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    
    switch (indexPath.row) {
        case 0:
        {
        
//            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width-100, 0, 50, 50)];
//            [button setTitle:@"完成" forState:UIControlStateNormal];
//            button.backgroundColor = [UIColor redColor];
            [cell.contentView addSubview:firstview];
        
        
        }
            break;
        case 1:
        {
        
            UILabel *screennamelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
            screennamelabel.text = [NSString stringWithFormat:@"云屏名称:%@",@"zhuchaopengdiannao"];
            [cell.contentView addSubview:screennamelabel];
            
            
        }
            break;
        case 2:
        {
    
        
        }
            break;
         case 3:
        {
        
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
        }
            break;
            
            
        default:
            break;
    }
    
    
    
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80;

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
