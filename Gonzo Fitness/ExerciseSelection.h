//
//  ExerciseSelection.h
//  Gonzo Fitness
//
//  Created by Joe Ginley on 1/15/13.
//  Copyright (c) 2013 Gonzo Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MediaPlayer/MediaPlayer.h>

@interface ExerciseSelection : UIViewController <NSXMLParserDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UIBarButtonItem *settingsButton;
    
    NSString *parentElement;
    NSString *currentElement;
    
    NSXMLParser * xmlParser;
    
    NSMutableArray *arrayImages;
    NSMutableArray *arrayTitles;
    NSMutableArray *arrayVideos;
    
    UINib *cellLoader;
    
    IBOutlet UITableView *exerciseTV;
    
    MPMoviePlayerController *mediaPlayer;
}

@end
