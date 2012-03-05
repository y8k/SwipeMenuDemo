//
//  AppDelegate.h
//  LeftMenuDemo
//
//  Created by YoonBong Kim on 12. 3. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>    {
    MenuViewController *_menuViewCntrlr;
}

@property (strong, nonatomic) UIWindow *window;

- (void)showMenu;

@end
