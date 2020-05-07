//
//  AppDelegate.m
//  ZCCSegmentView
//
//  Created by Laibu tech_2 on 2020/4/28.
//  Copyright © 2020 Laibu tech_2. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen]. bounds;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"mainVC"];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];
    return YES;
}



@end
