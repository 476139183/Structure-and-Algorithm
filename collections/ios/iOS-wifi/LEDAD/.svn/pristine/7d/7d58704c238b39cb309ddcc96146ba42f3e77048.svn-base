//
//  SearchViewController.m
//  LED2Buy
//
//  Created by LDY on 14-7-11.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "SearchViewController.h"
#import "Config.h"
#import "SearchDatabase.h"
#import "ListPullViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"产品搜索";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backToMainView)];
    
    mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, [Config currentNavigateHeight], SCREEN_CGSIZE_WIDTH, 50)];
    mySearchBar.delegate = self;
    mySearchBar.showsCancelButton = YES;
    [self.view addSubview:mySearchBar];
    
    historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [Config currentNavigateHeight] + 50, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - [Config currentNavigateHeight] - 50) style:UITableViewStyleGrouped];
    historyTableView.tag = TAG_HISTORY_TABLEVIEW;
    historyTableView.backgroundColor = [UIColor lightGrayColor];
    historyTableView.delegate = self;
    historyTableView.dataSource = self;
    [self.view addSubview:historyTableView];
    //test2014年07月14日
//    searchController = [[UISearchDisplayController alloc]
//                        initWithSearchBar:mySearchBar contentsController:self];
//    searchController.delegate = self;
//    searchController.searchResultsDataSource = self;
//    searchController.searchResultsDelegate = self;
    searchContents = [[NSMutableArray alloc] init];
    
    //测试智能下拉keyword列表
    keywordsListTV = [[UITableView alloc] initWithFrame:CGRectMake(10, mySearchBar.frame.origin.y + 40, SCREEN_CGSIZE_WIDTH - 65, 120) style:UITableViewStylePlain];
    keywordsListTV.tag = TAG_KEYWORDS_TABLEVIEW + 110;
    keywordsListTV.hidden = YES;
    keywordsListTV.delegate = self;
    keywordsListTV.dataSource = self;
//    [self.view addSubview:keywordsListTV];
}

//返回主页
- (void)backToMainView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSInteger heightForHeaderInSection = 0;
    if (tableView.tag == TAG_HISTORY_TABLEVIEW) {
        heightForHeaderInSection = 30;
    }else if (tableView.tag == TAG_KEYWORDS_TABLEVIEW) {
        heightForHeaderInSection = 0;
    }
    return heightForHeaderInSection;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSInteger heightForFooterInSection = 0;
    if (tableView.tag == TAG_HISTORY_TABLEVIEW) {
        heightForFooterInSection = 80;
    }else if (tableView.tag == TAG_KEYWORDS_TABLEVIEW) {
        heightForFooterInSection = 0;
    }
    return heightForFooterInSection;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, 30)];
//    searchLabel.backgroundColor = [UIColor whiteColor];
//    searchLabel.font = [UIFont systemFontOfSize:13];
//    searchLabel.text = @"  搜索风向标";
//    return searchLabel;
//}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearButton.frame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, 80);
    [clearButton setBackgroundColor:[UIColor whiteColor]];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [clearButton setTitle:@"清除搜索记录" forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [clearButton addTarget:self action:@selector(clearSearchHistory) forControlEvents:UIControlEventTouchUpInside];
    return clearButton;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == TAG_HISTORY_TABLEVIEW) {
        keywordsUrl = [NSString stringWithFormat:@"%@%@",URL_SEARCH_PRODUCTS, [searchContents objectAtIndex:(searchContents.count - indexPath.row - 1)]];
        DLog(@"keywordsUrl = %@",keywordsUrl);
        [self loadProductsList];
    }
    
    if (tableView.tag == TAG_KEYWORDS_TABLEVIEW) {
        mySearchBar.text = [NSString stringWithFormat:@"Test%d",indexPath.row];
        keywordsListTV.hidden = YES;
    }
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"搜索风向标";
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInSection = 0;
    if (tableView.tag == TAG_HISTORY_TABLEVIEW) {
        searchDatabase = [[SearchDatabase alloc] init];
        searchContents = [searchDatabase getAllSearchContents];
        numberOfRowsInSection = [searchContents count];
    }else if (tableView.tag == TAG_KEYWORDS_TABLEVIEW) {
        numberOfRowsInSection = 3;
    }
    return numberOfRowsInSection;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *MyIdentifier = [[NSString alloc] initWithFormat:@"%d",indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier] autorelease];
    }
    if (tableView.tag == TAG_HISTORY_TABLEVIEW) {
        if (searchContents.count != 0) {
            cell.textLabel.text = [searchContents objectAtIndex:(searchContents.count - indexPath.row - 1)];
        }
        cell.imageView.image = [UIImage imageNamed:@"history_normal"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (tableView.tag == TAG_KEYWORDS_TABLEVIEW) {
        tableView.layer.borderWidth = 1;
        tableView.layer.borderColor = [[UIColor blackColor] CGColor];//设置列表边框
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.textLabel.text = [NSString stringWithFormat:@"Test%d",indexPath.row];
    }
    
    return cell;
}


#pragma mark - UISearchDisplayDelegate
- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    
    mySearchBar.frame = CGRectMake(0, [Config topOffsetHeight], SCREEN_CGSIZE_WIDTH, 50);
    historyTableView.frame = CGRectMake(0, [Config topOffsetHeight] + 50, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - [Config topOffsetHeight] - 50);
}
- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    
}
- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    mySearchBar.frame = CGRectMake(0, [Config currentNavigateHeight], SCREEN_CGSIZE_WIDTH, 50);
    historyTableView.frame = CGRectMake(0, [Config currentNavigateHeight] + 50, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - [Config currentNavigateHeight] - 50);
}
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    DLog(@"searchBarTextDidBeginEditing")
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    DLog(@"searchBarShouldEndEditing")
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    DLog(@"searchBarTextDidEndEditing")
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    DLog("textDidChange");
    NSString *changingKeywordsUrl = [NSString stringWithFormat:@"%@%@",URL_GET_KEYWORDS, searchText];
    DLog(@"changingKeywordsUrl = %@",changingKeywordsUrl);
    keywordsListTV.hidden = NO;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    DLog("搜索......");
    [searchBar resignFirstResponder];
    
    //加载搜索到的产品列表
    keywordsUrl = [NSString stringWithFormat:@"%@%@",URL_SEARCH_PRODUCTS, searchBar.text];
    DLog(@"keywordsUrl = %@",keywordsUrl);
    [self loadProductsList];
    
    //把搜索历史添加到数据库
    for (NSString *tmpString in searchContents) {
        if ([[searchBar.text uppercaseString]isEqualToString:[tmpString uppercaseString]]) {
            return;
        }
    }
    searchDatabase = [[SearchDatabase alloc] init];
    [searchDatabase saveSearchDataArray:searchBar.text];
    searchContents = [searchDatabase getAllSearchContents];
//    [searchContents addObject:searchBar.text];
    [historyTableView reloadData];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    searchBar.text=nil;
    [searchBar resignFirstResponder];
    keywordsListTV.hidden = YES;
}

/** 加载搜索到的产品列表 */
- (void)loadProductsList
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"fromSearchVC" forKey:@"segmentYesOrNo"];
    ListPullViewController *productListVC = [[ListPullViewController alloc] init];
    [productListVC reloadSearchData:keywordsUrl];
    [self.navigationController pushViewController:productListVC animated:YES];
}

/**
 * 清除搜索历史记录
 */
-(void)clearSearchHistory
{
    searchDatabase = [[SearchDatabase alloc] init];
    [searchDatabase deleteAllSearchContents];
    searchContents = [searchDatabase getAllSearchContents];
    [historyTableView reloadData];
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
