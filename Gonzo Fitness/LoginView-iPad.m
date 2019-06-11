//
//  LoginView-iPad.m
//  Gonzo Fitness
//
//  Created by Joe Ginley on 6/13/13.
//  Copyright (c) 2013 Gonzo Fitness. All rights reserved.
//

#import "LoginView-iPad.h"

#import "AppDelegate.h"

#import "WorkoutSelection.h"

@implementation LoginView_iPad
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
    
    UIImage *buttonImage = [[UIImage imageNamed:@"whiteButton"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"whiteButtonHighlight"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [loginButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [loginButton setBackgroundImage:buttonImage forState:UIControlStateDisabled];
    [loginButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    if (appDel.StoredEmail.length > 0 && appDel.StoredPassword.length > 0)
    {
        emailField.text = appDel.StoredEmail;
        passField.text = appDel.StoredPassword;
        [self loginNow];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [emailField resignFirstResponder];
    [passField resignFirstResponder];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)emailFieldDone
{
    if (passField.text.length > 0 && emailField.text.length > 0)
    {
        [self resignFirstResponder];
        [self loginNow];
    }
    else
    {
        [passField becomeFirstResponder];
    }
}

- (IBAction)passFieldDone
{
    if (passField.text.length > 0 && emailField.text.length > 0)
    {
        [self resignFirstResponder];
        [self loginNow];
    }
    else
    {
        [emailField becomeFirstResponder];
    }
}

- (IBAction)loginNow
{
    if (passField.text.length == 0 && emailField.text.length == 0)
    {
        return;
    }
    
    [loginLabel setHidden:TRUE];
    [loadLoginIndicator setHidden:FALSE];
    [loginButton setEnabled:FALSE];
    [passField setEnabled:FALSE];
    [emailField setEnabled:FALSE];
    
    [self checkUser:[NSString stringWithFormat:@"https://gonzoworkout.com/mobileLoginChecker.php?email=%@&password=%@", emailField.text, passField.text]];
}

-(void)checkUser:(NSString *)url
{
    loginresponseData = [NSMutableData data];
    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:15.0];
    userConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    [userConnection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == userConnection)
    {
        [loginresponseData appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    if (connection == userConnection)
    {
        NSString *responseString = [[NSString alloc] initWithData:loginresponseData encoding:NSUTF8StringEncoding];
        loginresponseData = nil;
        
        [loadLoginIndicator setHidden:TRUE];
        
        if ([responseString rangeOfString:@"yes"].location != NSNotFound)
        {
            [loginLabel setTextColor:[UIColor blueColor]];
            [loginLabel setText:@"Login Successful!"];
            [loginLabel setHidden:FALSE];
            
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            
            [standardUserDefaults setObject:emailField.text forKey:@"storedEmail"];
            
            [standardUserDefaults setObject:passField.text forKey:@"storedPass"];
            
            [standardUserDefaults synchronize];
            
            appDel.StoredEmail = emailField.text;
            appDel.StoredPassword = passField.text;
            
            WorkoutSelection *workoutSelectionView = [[WorkoutSelection alloc] initWithNibName:@"WorkoutSelection" bundle:nil];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:workoutSelectionView];
            [self presentViewController:navController animated:YES completion:nil];
        }
        else
        {
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            if ([standardUserDefaults objectForKey:@"storedPass"])
            {
                [standardUserDefaults removeObjectForKey:@"storedPass"];
                [standardUserDefaults synchronize];
            }
            [loginLabel setTextColor:[UIColor redColor]];
            [loginLabel setText:@"Login Failed!"];
            [loginLabel setHidden:FALSE];
            [loginButton setEnabled:TRUE];
            
            [passField setEnabled:TRUE];
            [emailField setEnabled:TRUE];
        }
    }
}

@end
