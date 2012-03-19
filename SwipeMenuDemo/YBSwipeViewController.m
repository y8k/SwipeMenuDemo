//
//  YBSwipeViewController.m
//  LeftMenuDemo
//
//  Created by YoonBong Kim on 12. 3. 5..
//  Copyright (c) 2012년 KTH. All rights reserved.
//

#import "YBSwipeViewController.h"
#import "AppDelegate.h"

#define kRevealWidth                265.0f

@interface YBSwipeViewController ()

@end

@implementation YBSwipeViewController

@synthesize delegate = _delegate;
@synthesize mainViewCntrlr = _mainViewCntrlr;
@synthesize menuViewContrlr = _menuViewContrlr;
@synthesize status = _status;
@synthesize menuGestureEnable = _menuGestureEnable;


- (id)initWithMainViewController:(UIViewController *)mainViewCntrlr menuViewController:(UIViewController *)menumViewCntrlr
{
    self = [super init];
    if (self) {
        
        _mainViewCntrlr  = [mainViewCntrlr retain];
        _menuViewContrlr = [menumViewCntrlr retain];
        
        _status = ViewStatusMain;
        
        _normPointX = 0.0f;
        _beginPointX = 0.0f;
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

    
    /* view for main */        
    _mainView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _mainView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_mainView];
    [_mainView release];
    
    
    {
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_mainView.bounds];
        [_mainView.layer setMasksToBounds:NO];
        [_mainView.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [_mainView.layer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
        [_mainView.layer setShadowOpacity:1.0f];
        [_mainView.layer setShadowRadius:4.5f];
        [_mainView.layer setShadowPath:shadowPath.CGPath];
        
        
        _menuGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
        _menuGestureRecognizer.maximumNumberOfTouches = 1;
        _menuGestureRecognizer.enabled = YES;
        
        [_mainView addGestureRecognizer:_menuGestureRecognizer];
        [_menuGestureRecognizer release];
    }

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


- (void)setMenuGestureEnable:(BOOL)menuGestureEnable    {
    _menuGestureEnable = menuGestureEnable;
    _menuGestureRecognizer.enabled = _menuGestureEnable;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    BOOL allowRotate = NO;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        allowRotate = YES;
    }
    else {
        allowRotate = (interfaceOrientation == UIInterfaceOrientationPortrait)? YES : NO;
    }
    
    return allowRotate;
}


- (void)setSearchMode:(BOOL)search animated:(BOOL)animated   {
    
    [UIView animateWithDuration:0.3f animations:^{
        
        if (search) {
            _mainView.transform = CGAffineTransformMakeTranslation(320.0f, 0.0f);
        }
        else {
            _mainView.transform = CGAffineTransformMakeTranslation(kRevealWidth, 0.0f);
        }
    }];
}


- (void)setShowMenu:(BOOL)show animated:(BOOL)animated  {
    
    if (animated) {
            
        if (show)   {
            
            if (_menuView == nil) {
                
                _menuView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
                
                [self.view insertSubview:_menuView belowSubview:_mainView];
                [_menuView release];
                
                [_menuView addSubview:_menuViewContrlr.view];
            }
            
            [_menuViewContrlr viewWillAppear:YES];
        }
        else {
            
            [_mainViewCntrlr viewWillAppear:YES];
            [_menuViewContrlr viewWillDisappear:YES];
        }
        
        
        [UIView animateWithDuration:0.2f animations:^{
            
            _mainView.transform = (show)?  CGAffineTransformMakeTranslation(kRevealWidth, 0.0f) : CGAffineTransformMakeTranslation(0.0f, 0.0f);
        } completion:^(BOOL finished) {
            
                //_menuGestureRecognizer.enabled = (show)? YES : NO;
            _status = (show)? ViewStatusMenu : ViewStatusMain;
            
            if (show)   {
                
                [_menuViewContrlr viewDidAppear:YES];
                
                BOOL interaction = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? YES : NO;

                [[[(UINavigationController *)_mainViewCntrlr visibleViewController] view] setUserInteractionEnabled:interaction];
                
            }
            else {
        
                [_mainViewCntrlr viewDidAppear:YES];
                [_menuViewContrlr viewDidDisappear:YES];
                
                if (_menuView != nil) {
                    [_menuView removeFromSuperview];
                    _menuView = nil;
                }
                                
                [[[(UINavigationController *)_mainViewCntrlr visibleViewController] view] setUserInteractionEnabled:YES];
                
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
        case UIGestureRecognizerStateBegan:
            
            _beginPointX = pointX;
            _normPointX = (self.status == ViewStatusMain)? 0.0f : kRevealWidth;
            
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGFloat move = pointX - _beginPointX;
            
            if (_status == ViewStatusMain) {
                
                if (_beginPointX > pointX) {   
                    return;
                }
                
                _status = (pointX > kRevealWidth / 2)? ViewStatusMenu : ViewStatusMain;
            }
            else if(_status == ViewStatusMenu)   {
                
                
                if (-kRevealWidth > move) {
                    return;
                }
                
                _status = (pointX < kRevealWidth)? ViewStatusMain : ViewStatusMenu;
            }
            else {
                
            }
            
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
        }           
            break;
        case UIGestureRecognizerStateChanged:
            
            if (_menuView == nil) {
                
                _menuView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
                
                [self.view insertSubview:_menuView belowSubview:_mainView];
                [_menuView release];
                
                [_menuView addSubview:_menuViewContrlr.view];
            }
            
            CGFloat move = pointX - _beginPointX;
            NSLog(@"move : %f", move);
            
            if (self.status == ViewStatusMain) {
                
                if (_beginPointX > pointX) {   
                    return;
                }
            }
            else {
                
                if (-kRevealWidth > move) {
                    return;
                }
            }
            
            _mainView.transform = CGAffineTransformMakeTranslation(_normPointX + move, 0.0f);
            
        
            break;
        default:
            break;
    }
}

@end
