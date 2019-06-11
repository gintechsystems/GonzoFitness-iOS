//
//  SettingsView-iPad.m
//  Gonzo Fitness
//
//  Created by Joe Ginley on 6/15/13.
//  Copyright (c) 2013 Gonzo Fitness. All rights reserved.
//

#import "SettingsView-iPad.h"

#import "AppDelegate.h"

#import "LoginView-iPad.h"

@implementation SettingsView_iPad
{
    AppDelegate *appDel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Settings";
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.text = self.title;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    [self.navigationItem.titleView sizeToFit];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    email.text = appDel.StoredEmail;
    
    UIImage *buttonImage = [[UIImage imageNamed:@"whiteButton"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"whiteButtonHighlight"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [logoutButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    mainLogo.frame = CGRectMake(mainLogo.frame.origin.x, mainLogo.frame.origin.y + 65, mainLogo.frame.size.width, mainLogo.frame.size.height);
    
    loggedUserLabel.frame = CGRectMake(loggedUserLabel.frame.origin.x, loggedUserLabel.frame.origin.y + 65, loggedUserLabel.frame.size.width, loggedUserLabel.frame.size.height);
    email.frame = CGRectMake(email.frame.origin.x, email.frame.origin.y + 65, email.frame.size.width, email.frame.size.height);
    
    logoutButton.frame = CGRectMake(logoutButton.frame.origin.x, logoutButton.frame.origin.y + 65, logoutButton.frame.size.width, logoutButton.frame.size.height);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doLogout_iPad
{
    /*NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([standardUserDefaults objectForKey:@"storedEmail"])
    {
        [standardUserDefaults removeObjectForKey:@"storedEmail"];
        [standardUserDefaults synchronize];
    }
    if ([standardUserDefaults objectForKey:@"storedPass"])
    {
        [standardUserDefaults removeObjectForKey:@"storedPass"];
        [standardUserDefaults synchronize];
    }
    
    [standardUserDefaults synchronize];
    
    appDel.StoredEmail = nil;
    appDel.StoredPassword = nil;
    
    LoginView_iPad *loginViewiPad = [[LoginView_iPad alloc] initWithNibName:@"LoginView-iPad" bundle:nil];
    [self presentViewController:loginViewiPad animated:YES completion:nil];*/
}

@end
