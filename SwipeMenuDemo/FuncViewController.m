//
//  FuncViewController.m
//  LeftMenuDemo
//
//  Created by YoonBong Kim on 12. 3. 5..
//  Copyright (c) 2012년 KTH. All rights reserved.
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


@end
