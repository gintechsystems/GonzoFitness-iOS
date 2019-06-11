//
//  SettingsView-iPad.h
//  Gonzo Fitness
//
//  Created by Joe Ginley on 6/15/13.
//  Copyright (c) 2013 Gonzo Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsView_iPad : UIViewController
{
    IBOutlet UILabel *loggedUserLabel;
    
    IBOutlet UILabel *email;
    IBOutlet UIButton *logoutButton;
    
    IBOutlet UIImageView *mainLogo;
    IBOutlet UIImageView *mainBG;
}

- (IBAction)doLogout_iPad;

@end
