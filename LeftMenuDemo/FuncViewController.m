//
//  FuncViewController.m
//  LeftMenuDemo
//
//  Created by YoonBong Kim on 12. 3. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "FuncViewController.h"
#import "AppDelegate.h"
#import "YBSwipeViewController.h"

@interface FuncViewController ()

@end

@implementation FuncViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"Etc.";
    }
    return self;
}


- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    UIBarButtonItem *testBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"MENU" style:UIBarButtonItemStyleBordered target:self action:@selector(onMenu)];
    self.navigationItem.leftBarButtonItem = testBarButtonItem;
    [testBarButtonItem release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - UIBarButtonItem selector

- (void)onMenu  {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    YBSwipeViewController *swipeViewCntrlr = (YBSwipeViewController *)[[appDelegate window] rootViewController];
    
    switch (swipeViewCntrlr.status) {
        case ViewStatusMain:
            [swipeViewCntrlr setShowMenu:YES animated:YES];
            break;
        case ViewStatusMenu:
            [swipeViewCntrlr setShowMenu:NO animated:YES];
            break;
        default:
            break;
    }
}


@end
