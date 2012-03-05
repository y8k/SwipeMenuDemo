//
//  MainViewController.m
//  LeftMenuDemo
//
//  Created by YoonBong Kim on 12. 3. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"

#import "YBSwipeViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"Main";
    }
    return self;
}


- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    
    UIBarButtonItem *testBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"MENU" style:UIBarButtonItemStyleBordered target:self action:@selector(onMenu)];
    self.navigationItem.leftBarButtonItem = testBarButtonItem;
    [testBarButtonItem release];
    
    
    UIBarButtonItem *pushBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PUSH" style:UIBarButtonItemStyleBordered target:self action:@selector(pushTest)];
    self.navigationItem.rightBarButtonItem = pushBarButtonItem;
    [pushBarButtonItem release];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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


- (void)pushTest    {
    
    DetailViewController *detailViewCntrlr = [[DetailViewController alloc] init];
    
    [self.navigationController pushViewController:detailViewCntrlr animated:YES];
    [detailViewCntrlr release];
    
}

@end
