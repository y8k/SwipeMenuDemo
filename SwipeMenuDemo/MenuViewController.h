//
//  MenuViewController.h
//  LeftMenuDemo
//
//  Created by YoonBong Kim on 12. 3. 5..
//  Copyright (c) 2012년 KTH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController    <UITableViewDataSource, UITableViewDelegate>  {
    UITableView *_menuTableView;
}

@end
