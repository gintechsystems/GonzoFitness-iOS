//
//  AppDelegate.m
//  Gonzo Fitness
//
//  Created by Joe Ginley on 1/6/13.
//  Copyright (c) 2013 Gonzo Fitness. All rights reserved.
//

#import "AppDelegate.h"

#import "WorkoutSelection.h"

@implementation AppDelegate
{
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.StoredEmail = @"kevin@gonzoworkout.com";
    
    /*NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([standardUserDefaults objectForKey:@"storedEmail"])
    {
        self.StoredEmail = [standardUserDefaults stringForKey:@"storedEmail"];
    }
    
    if ([standardUserDefaults objectForKey:@"storedPass"])
    {
        self.StoredPassword = [standardUserDefaults stringForKey:@"storedPass"];
    }
    */
    
    // This app is no longer being maintained with user login, bypass this.
    WorkoutSelection *workoutSelectionView = [[WorkoutSelection alloc] initWithNibName:@"WorkoutSelection" bundle:nil];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:workoutSelectionView];
    
    // Allows for light content status bar style to work.
    [navController.navigationBar setBarStyle:UIBarStyleBlack];
    
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
