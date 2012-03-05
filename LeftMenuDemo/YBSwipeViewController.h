//
//  YBSwipeViewController.h
//  LeftMenuDemo
//
//  Created by YoonBong Kim on 12. 3. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum    {
    ViewStatusMain = 100,
    ViewStatusMenu,
} ViewStatus;


@protocol YBSwipeViewControllerDelegate <NSObject>

@optional

- (void)swipeViewController:(UIViewController *)controller willShowMenuViewController:(UIViewController *)menuViewCntrlr;

@end


@interface YBSwipeViewController : UIViewController {
    id _delegate;
    
    UIViewController *_mainViewCntrlr;
    UIViewController *_menuViewContrlr;
    
    UIView *_mainView;
    UIView *_menuView;
    
    UIPanGestureRecognizer *_menuGestureRecognizer;
    
    ViewStatus _status;
}

@property (nonatomic, assign) id <YBSwipeViewControllerDelegate>delegate;
@property (nonatomic, retain) UIViewController *mainViewCntrlr;
@property (nonatomic, retain) UIViewController *menuViewContrlr;
@property (nonatomic, assign) ViewStatus status;

- (id)initWithMainViewController:(UIViewController *)mainViewCntrlr menuViewController:(UIViewController *)menumViewCntrlr;
- (void)setSelectMenu:(UIViewController *)viewCntrlr animated:(BOOL)animated;
- (void)setShowMenu:(BOOL)show animated:(BOOL)animated;

@end
