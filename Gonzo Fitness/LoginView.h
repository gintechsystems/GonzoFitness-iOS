//
//  LoginView.h
//  Gonzo Fitness
//
//  Created by Joe Ginley on 1/6/13.
//  Copyright (c) 2013 Gonzo Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIViewController
{
    IBOutlet UITextField *emailField;
    IBOutlet UITextField *passField;
    
    IBOutlet UIButton *loginButton;
    
    IBOutlet UIActivityIndicatorView *loadLoginIndicator;
    
    IBOutlet UILabel *loginLabel;
    
    NSMutableData *loginresponseData;
    NSURLConnection *userConnection;
    
    UIView *workoutView;
}

- (IBAction)emailFieldDone;
- (IBAction)passFieldDone;
- (IBAction)loginNow;

@end
