//
//  DetailViewController.m
//  LeftMenuDemo
//
//  Created by YoonBong Kim on 12. 3. 5..
//  Copyright (c) 2012년 KTH. All rights reserved.
//

#import "DetailViewController.h"
#import "BaseViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"Detail";
    }
    return self;
}


- (void)loadView
{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor magentaColor]];
}


- (void)viewWillAppear:(BOOL)animated   {
    [super viewWillAppear:animated];
    
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

@end
