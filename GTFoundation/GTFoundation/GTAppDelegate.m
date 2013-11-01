//
//  GTAppDelegate.m
//  GTFoundation
//
//  Created by Gianluca Tranchedone on 01/11/2013.
//  Copyright (c) 2013 Cocoa Beans GT Limited. All rights reserved.
//

#import "GTAppDelegate.h"
#import "GTDemosListViewController.h"

@implementation GTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    GTDemosListViewController *demosListViewController = [[GTDemosListViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:demosListViewController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
