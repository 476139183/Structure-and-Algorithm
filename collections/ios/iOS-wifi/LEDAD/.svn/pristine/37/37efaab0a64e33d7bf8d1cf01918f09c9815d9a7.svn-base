//
//  FDFontPickerViewController.h
//  FDLabelView
//
//  Created by magic on 8/9/13.
//  Copyright (c) 2013 Fourdesire. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FDFontPickerDelegate <NSObject>

-(void)fontDidSelect:(NSString*)fontName;

@end

@interface FDFontPickerViewController : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate> {
    UISearchBar* _searchBar;
    UISearchDisplayController* _searchController;
    BOOL _isFiltered;
    NSArray* _filteredFonts;
    UIButton* _applyBtn;
}

@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, retain) NSString* fontName;
@property(nonatomic, retain) id<FDFontPickerDelegate> delegate;
@property(nonatomic, retain) NSArray* fonts;
@end
