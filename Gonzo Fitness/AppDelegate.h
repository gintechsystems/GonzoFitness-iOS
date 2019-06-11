//
//  AppDelegate.h
//  Gonzo Fitness
//
//  Created by Joe Ginley on 1/6/13.
//  Copyright (c) 2013 Gonzo Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) NSString *StoredEmail;

@property (nonatomic, retain) NSString *StoredPassword;

@property (nonatomic, retain) NSString *CurrentWorkoutNumberString;

@property (nonatomic, retain) NSString *CurrentWorkoutExerciseNumberString;

@end
