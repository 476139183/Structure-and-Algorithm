//
//  DetailVC.m
//  LEDAD
//
//  yixingman on 11-10-22.
//  ledmedia All rights reserved.
//

#import "DetailVC.h"


@implementation DetailVC
@synthesize toolbar;

- (void)viewDidUnload {
	[super viewDidUnload];
	
	self.toolbar = nil;
}

#pragma mark SubstitutableDetailViewController 协议实现

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Add the popover button to the toolbar.
    NSMutableArray *itemsArray = [toolbar.items mutableCopy];
    [itemsArray insertObject:barButtonItem atIndex:0];
    [toolbar setItems:itemsArray animated:NO];
    [itemsArray release];
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Remove the popover button from the toolbar.
    NSMutableArray *itemsArray = [toolbar.items mutableCopy];
    [itemsArray removeObject:barButtonItem];
    [toolbar setItems:itemsArray animated:NO];
    [itemsArray release];
}

#pragma mark 旋屏支持
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
#pragma mark -
- (void)dealloc {
    [toolbar release];
    [super dealloc];
}	
@end