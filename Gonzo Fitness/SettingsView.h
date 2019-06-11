//
//  SettingsView.h
//  Gonzo Fitness
//
//  Created by Joe Ginley on 1/8/13.
//  Copyright (c) 2013 Gonzo Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsView : UIViewController
{
    IBOutlet UILabel *loggedUserLabel;
    
    IBOutlet UILabel *email;
    IBOutlet UIButton *logoutButton;
    
    IBOutlet UIImageView *mainLogo;
    IBOutlet UIImageView *mainBG;
}

- (IBAction)doLogout;

@end
