//
//  WorkoutSelection.h
//  Gonzo Fitness
//
//  Created by Joe Ginley on 1/8/13.
//  Copyright (c) 2013 Gonzo Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutSelection : UIViewController <NSXMLParserDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UIBarButtonItem *settingsButton;
    UIBarButtonItem *backButton;
    
    NSXMLParser *xmlParser;
    
    NSMutableArray *arrayWorkouts;
    
    IBOutlet UITableView *workoutTV;
}

@end
