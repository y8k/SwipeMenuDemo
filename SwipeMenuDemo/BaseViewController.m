//
//  BaseViewController.m
//  LeftMenuDemo
//
//  Created by YoonBong Kim on 12. 3. 19..
//  Copyright (c) 2012년 KTH. All rights reserved.
//

#import "BaseViewController.h"
#import "YBSwipeViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

- (void)enableMenuGesture:(BOOL)enable;

@end

@implementation BaseViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)loadView    {
    [super loadView];
    
    
}


- (void)viewWillAppear:(BOOL)animated    {
    [super viewWillAppear:animated];
        
    
    /* If instance is first(top) view controller, it can swipe for appearing menu. but if pushed view controller, can't */
    if ([[[self.navigationController viewControllers] objectAtIndex:0] isEqual:self]) {

        UIBarButtonItem *menuBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(onMenu)];
        self.navigationItem.leftBarButtonItem = menuBarButtonItem;
        [menuBarButtonItem release];
        
        [self enableMenuGesture:YES];
    }
    else {
        
        self.navigationItem.leftBarButtonItem = nil;
        
        [self enableMenuGesture:NO];
    }
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


/* Menu button selector in left navigation */
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


/* swipe gesture enable/disable method */
- (void)enableMenuGesture:(BOOL)enable  {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    YBSwipeViewController *swipeViewCntrlr = (YBSwipeViewController *)[[appDelegate window] rootViewController];
    swipeViewCntrlr.menuGestureEnable = enable;
}

@end
