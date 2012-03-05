//
//  MenuViewController.m
//  LeftMenuDemo
//
//  Created by YoonBong Kim on 12. 3. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "YBSwipeViewController.h"
#import "MainViewController.h"
#import "FuncViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
    _menuTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    _menuTableView.dataSource = self;
    _menuTableView.delegate = self;
    
    [self.view addSubview:_menuTableView];
    [_menuTableView release];

}


- (void)viewWillAppear:(BOOL)animated   {
    [super viewWillAppear:animated];
    
}


- (void)viewDidAppear:(BOOL)animated    {
    [super viewDidAppear:animated];
    
}


- (void)viewWillDisappear:(BOOL)animated    {
    [super viewWillDisappear:animated];
    
    
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
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


#pragma mark - UITableView dataSource, delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView   {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section    {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    static NSString *identifier = @"menu";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"menu %d", indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    YBSwipeViewController *swipeViewCntrlr = (YBSwipeViewController *)[appDelegate.window rootViewController];
    
    UIViewController *viewCntrlr = nil;
    
    if (indexPath.row == 0) {
        MainViewController *mainViewCntrlr = [[MainViewController alloc] init];
        viewCntrlr = mainViewCntrlr;

    }
    else {
        FuncViewController *funcViewCntrlr = [[FuncViewController alloc] init];
        viewCntrlr = funcViewCntrlr;
    }
    
    [swipeViewCntrlr setSelectMenu:viewCntrlr animated:YES];
    [viewCntrlr release];
        
}

@end
