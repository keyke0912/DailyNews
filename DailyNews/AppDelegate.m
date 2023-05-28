//
//  AppDelegate.m
//  DailyNews
//
//  Created by Key ke on 2023/4/21.
//

#import "AppDelegate.h"
#import "MainPageViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    MainPageViewController *vc = [[MainPageViewController alloc]init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
//    [navigationController.navigationBar setAlpha:0.0];
    //navigationController.navigationBarHidden = YES;
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
//    [UINavigationBar appearance].hidden = NO;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    return YES;
}




@end
