//
//  AppDelegate.h
//  ListProcesses
//
//  Created by Philippe Jayet on 15.03.12.
//  Copyright (c) 2012 Easybox Technologies Sarl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProcessesViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ProcessesViewController *viewController;

@end
