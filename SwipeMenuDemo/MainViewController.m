//
//  MainViewController.m
//  LeftMenuDemo
//
//  Created by YoonBong Kim on 12. 3. 5..
//  Copyright (c) 2012년 KTH. All rights reserved.
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
    
    
    UIBarButtonItem *pushBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Detail" style:UIBarButtonItemStyleBordered target:self action:@selector(pushTest)];
    self.navigationItem.rightBarButtonItem = pushBarButtonItem;
    [pushBarButtonItem release];
    
}


- (void)viewWillAppear:(BOOL)animated   {
    [super viewWillAppear:animated];
    
    NSLog(@"appearing..");
}

- (void)viewWillDisappear:(BOOL)animated    {
    [super viewWillDisappear:animated];
    
    NSLog(@"disappearing..");
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
    [super onMenu];
}


- (void)pushTest    {
    
    DetailViewController *detailViewCntrlr = [[DetailViewController alloc] init];
    
    [self.navigationController pushViewController:detailViewCntrlr animated:YES];
    [detailViewCntrlr release];
    
}

@end
