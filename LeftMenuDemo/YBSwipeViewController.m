//
//  YBSwipeViewController.m
//  LeftMenuDemo
//
//  Created by YoonBong Kim on 12. 3. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "YBSwipeViewController.h"

#define kRevealWidth                270.0f

@interface YBSwipeViewController ()

@end

@implementation YBSwipeViewController

@synthesize delegate = _delegate;
@synthesize mainViewCntrlr = _mainViewCntrlr;
@synthesize menuViewContrlr = _menuViewContrlr;
@synthesize status = _status;

- (id)initWithMainViewController:(UIViewController *)mainViewCntrlr menuViewController:(UIViewController *)menumViewCntrlr
{
    self = [super init];
    if (self) {
        
        _mainViewCntrlr  = [mainViewCntrlr retain];
        _menuViewContrlr = [menumViewCntrlr retain];
        
        _status = ViewStatusMain;
    }
    return self;
}


- (void)dealloc {
    [_mainViewCntrlr release];
    _mainViewCntrlr = nil;
    
    [_menuViewContrlr release];
    _menuViewContrlr = nil;
    
    [super dealloc];
}


- (void)loadView
{
    [super loadView];
    
    self.wantsFullScreenLayout = YES;
    
    
    /* 메뉴를 보여주기 위한 뷰 */
    _menuView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self.view addSubview:_menuView];
    [_menuView release];
    
    
    /* 메인 화면을 보여주기 위한 뷰 */
    _mainView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _mainView.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:_mainView];
    [_mainView release];
    
    {
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_mainView.bounds];
        [_mainView.layer setMasksToBounds:NO];
        [_mainView.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [_mainView.layer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
        [_mainView.layer setShadowOpacity:1.0f];
        [_mainView.layer setShadowRadius:2.5f];
        [_mainView.layer setShadowPath:shadowPath.CGPath];
        
        
        _menuGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
        _menuGestureRecognizer.enabled = NO;
        
        [_mainView addGestureRecognizer:_menuGestureRecognizer];
        [_menuGestureRecognizer release];
    }

       
    [_menuView addSubview:_menuViewContrlr.view];
    [_mainView addSubview:_mainViewCntrlr.view];    
}


- (void)viewWillAppear:(BOOL)animated   {
    [super viewWillAppear:animated];
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    _mainView = nil;
    _menuView = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)setShowMenu:(BOOL)show animated:(BOOL)animated  {
    
    if (animated) {
            
        if (show)   {
            [_menuViewContrlr viewWillAppear:YES];
        }
        else {
            [_menuViewContrlr viewWillDisappear:YES];
        }
        
        
        [UIView animateWithDuration:0.2f animations:^{
            
            _mainView.transform = (show)?  CGAffineTransformMakeTranslation(kRevealWidth, 0.0f) : CGAffineTransformMakeTranslation(0.0f, 0.0f);
        } completion:^(BOOL finished) {
            
            _menuGestureRecognizer.enabled = (show)? YES : NO;
            _status = (show)? ViewStatusMenu : ViewStatusMain;
            
            if (show)   {
                [_menuViewContrlr viewDidAppear:YES];
            }
            else {
                [_menuViewContrlr viewDidDisappear:YES];
            }
        }];
        
    }
    else {
        _mainView.transform = (show)?  CGAffineTransformMakeTranslation(kRevealWidth, 0.0f) : CGAffineTransformMakeTranslation(0.0f, 0.0f);
    }
}


- (void)setSelectMenu:(UIViewController *)viewCntrlr animated:(BOOL)animated    {
    
    if (animated) {
        
        [UIView animateWithDuration:0.3f animations:^{
            
            _mainView.transform = CGAffineTransformMakeTranslation(320.0f, 0.0f);
                        
        } completion:^(BOOL finished) {
            
            
            NSLog(@"main : %@", [_mainViewCntrlr class]);
            
            if ([_mainViewCntrlr isKindOfClass:[UINavigationController class]]) {
                
                [(UINavigationController *)_mainViewCntrlr setViewControllers:[NSArray arrayWithObject:viewCntrlr]];
            }
            
            [self setShowMenu:NO animated:YES];
        }];
    }
    else {
        [self setShowMenu:NO animated:YES];
    }
}


#pragma mark - UIPanGestureRecognizer selector

- (void)onSwipe:(UIPanGestureRecognizer *)recognizer    {
    
    UIGestureRecognizerState state = recognizer.state;
    CGFloat pointX = [recognizer locationInView:self.view].x;
    
    switch (state) {
        case UIGestureRecognizerStateEnded:
            
            _status = (pointX < kRevealWidth)? ViewStatusMain : ViewStatusMenu;
            
            switch (_status) {
                case ViewStatusMenu:
                    [self setShowMenu:YES animated:YES];
                    break;
                case ViewStatusMain:
                    [self setShowMenu:NO animated:YES];
                    break;
                default:
                    break;
            }
                    
            break;
        case UIGestureRecognizerStateChanged:
            
            _mainView.transform = CGAffineTransformMakeTranslation(pointX, 0.0f);
            
            break;
        default:
            break;
    }
}

@end
