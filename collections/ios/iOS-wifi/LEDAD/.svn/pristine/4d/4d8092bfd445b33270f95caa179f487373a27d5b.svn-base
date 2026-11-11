//
//  FDFontPickerViewController.m
//  FDLabelView
//
//  Created by magic on 8/9/13.
//  Copyright (c) 2013 Fourdesire. All rights reserved.
//

#import "FDFontPickerViewController.h"
#import "FDLabelConfigViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FDFontPickerViewController ()

@end

@implementation FDFontPickerViewController
@synthesize fonts, fontName, delegate, tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
        NSMutableArray* array = [NSMutableArray array];
        for (int i = 0; i < familyNames.count; i++)
        {
            [array addObjectsFromArray:[UIFont fontNamesForFamilyName:familyNames[i]]];
        }
        fonts = [NSArray arrayWithArray:array];
        _filteredFonts = [NSArray array];
    }
    return self;
}

-(void)loadView{
    [super loadView];
    
    CGSize screen = [UIScreen mainScreen].bounds.size;
    self.view.frame = CGRectMake(-kEditorWidth, 0, kEditorWidth, screen.height);
    
    UILabel* titleView = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 80, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.textColor = [UIColor whiteColor];
    titleView.textAlignment = NSTextAlignmentLeft;
    titleView.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:18];
    titleView.text = @"Font Picker";
    
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kEditorWidth, 44)];
    header.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    [header addSubview:titleView];
    
    UIButton* closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
    closeBtn.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    closeBtn.layer.cornerRadius = 10;
    closeBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
    [closeBtn setTitle:@"<" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:closeBtn];
    
    _applyBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEditorWidth - 50, 12, 40, 20)];
    _applyBtn.hidden = YES;
    _applyBtn.backgroundColor = [UIColor colorWithRed:0.11f green:0.53f blue:0.82f alpha:1.00f];
    _applyBtn.layer.cornerRadius = 10;
    _applyBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12];
    [_applyBtn setTitle:@"save" forState:UIControlStateNormal];
    [_applyBtn addTarget:self action:@selector(apply) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:_applyBtn];
    
    [self.view addSubview:header];
    
    // Search
    UISearchBar* searchBar = [[UISearchBar alloc] init];
    [searchBar sizeToFit];
    searchBar.delegate = self;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:searchBar];
    
    _searchBar = searchBar;
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kEditorWidth, screen.height - 44) style:UITableViewStyleGrouped];
    tableView.tableHeaderView = searchBar;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    _searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    _searchController.delegate = self;
    _searchController.searchResultsDataSource = self;
    _searchController.searchResultsDelegate = self;
    _searchController.searchResultsTableView.frame = self.view.bounds;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(0, 0, kEditorWidth, self.view.frame.size.height);
    }];
    
    _applyBtn.hidden = YES;
    
    NSUInteger index = [fonts indexOfObject:fontName];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    
}

-(void)close{
    if (delegate && [delegate respondsToSelector:@selector(fontDidSelect:)]) {
        [delegate fontDidSelect:fontName];
    }
    
    [self apply];
}

-(void)apply{
    [UIView animateWithDuration:0.3 delay:0 options:0 animations:^{
        self.view.frame = CGRectMake(-kEditorWidth, 0, kEditorWidth, self.view.frame.size.height);
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _isFiltered? _filteredFonts.count : fonts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }

    cell.textLabel.font = [UIFont fontWithName:fonts[indexPath.row] size:12];
    cell.textLabel.text = _isFiltered? _filteredFonts[indexPath.row] : fonts[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (delegate && [delegate respondsToSelector:@selector(fontDidSelect:)]) {
        [delegate fontDidSelect:_isFiltered? _filteredFonts[indexPath.row] : fonts[indexPath.row]];
    }
    
    _applyBtn.hidden = NO;
}

#pragma mark - UISearchBar

- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
    _isFiltered = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length > 0) {
        _isFiltered = YES;
        NSMutableArray* filteredData = [[NSMutableArray alloc] init];

        for (NSString* font in fonts)
        {
            NSRange nameRange = [font rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(nameRange.location != NSNotFound)
            {
                [filteredData addObject:font];
            }
        }
        _filteredFonts = [NSArray arrayWithArray:filteredData];
    }else{
        _isFiltered = NO;
    }
}


@end
