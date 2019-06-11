//
//  ExerciseSelection.m
//  Gonzo Fitness
//
//  Created by Joe Ginley on 1/15/13.
//  Copyright (c) 2013 Gonzo Fitness. All rights reserved.
//

#import "ExerciseSelection.h"

#import "ExerciseCell.h"

#import "SettingsView.h"

#import "AppDelegate.h"

#import "SettingsView-iPad.h"

@implementation ExerciseSelection
{
    AppDelegate *appDel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        cellLoader = [UINib nibWithNibName:@"ExerciseCell" bundle:[NSBundle mainBundle]];
    }
    return self;
}

/*- (void)viewDidLayoutSubviews
{
    if (appDel.iOS7)
    {
        UIEdgeInsets inset = [exerciseTV contentInset];
        inset.top = [self.topLayoutGuide length];
        inset.bottom = [self.bottomLayoutGuide length];
        [exerciseTV setContentInset:inset];
    }
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *finalworkoutName = [NSString alloc];
    if ([appDel.CurrentWorkoutNumberString intValue] == 16)
    {
        if ([[UIDevice currentDevice].model hasPrefix:@"iPhone"])
        {
             finalworkoutName = [NSString stringWithFormat:@"%s", "Stretch"];
        }
        else
        {
             finalworkoutName = [NSString stringWithFormat:@"%s", "Stretch Session (21 Exercises)"];
        }
    }
    else
    {
        if ([[UIDevice currentDevice].model hasPrefix:@"iPhone"])
        {
            finalworkoutName = [NSString stringWithFormat:@"%s%@", "Workout ", appDel.CurrentWorkoutNumberString];
        }
        else
        {
            finalworkoutName = [NSString stringWithFormat:@"%s%@ (%@)", "Workout ", appDel.CurrentWorkoutNumberString, appDel.CurrentWorkoutExerciseNumberString];
        }
    } 
    self.title = finalworkoutName;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.text = self.title;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    [self.navigationItem.titleView sizeToFit];
    
    settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsClicked)];
    self.navigationItem.rightBarButtonItem = settingsButton;
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [settingsButton setTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view from its nib.
    arrayImages = [[NSMutableArray alloc] init];
    arrayTitles = [[NSMutableArray alloc] init];
    arrayVideos = [[NSMutableArray alloc] init];
    
    exerciseTV.delegate = self;
    
    mediaPlayer = [[MPMoviePlayerController alloc] init];
    mediaPlayer.movieSourceType = MPMovieSourceTypeStreaming;
    if ([[UIDevice currentDevice].model hasPrefix:@"iPhone"])
    {
        mediaPlayer.scalingMode = MPMovieScalingModeAspectFill;
    }
    else
    {
        mediaPlayer.scalingMode = MPMovieScalingModeNone;
    }
    [mediaPlayer setControlStyle:MPMovieControlStyleFullscreen];
    [mediaPlayer setAllowsAirPlay:TRUE];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
	if ([arrayImages count] == 0 || [arrayTitles count] == 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource: @"configworkout" ofType:@"xml"];
		NSURL *xmlurl = [NSURL fileURLWithPath:path];
        xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlurl];
        [xmlParser setDelegate:self];
        [xmlParser setShouldProcessNamespaces:NO];
        [xmlParser setShouldReportNamespacePrefixes:NO];
        [xmlParser setShouldResolveExternalEntities:NO];
        [xmlParser parse];
        
        [exerciseTV reloadData];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)settingsClicked
{
    if ([[UIDevice currentDevice].model hasPrefix:@"iPhone"])
    {
        SettingsView *screen = [[SettingsView alloc] initWithNibName:@"SettingsView" bundle:nil];
        [self.navigationController pushViewController:screen animated:YES];
    }
    else
    {
        SettingsView_iPad *screen = [[SettingsView_iPad alloc] initWithNibName:@"SettingsView-iPad" bundle:nil];
        [self.navigationController pushViewController:screen animated:YES];
    }
}

-(void)parser:(NSXMLParser *) parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"workout"]) {
        NSString *workoutID = [attributeDict objectForKey:@"id"];
        if (![workoutID isEqualToString:appDel.CurrentWorkoutNumberString])
        {
            parentElement = nil;
        }
        else
        {
            parentElement = [[NSString alloc] init];
            parentElement = elementName;
        }
    }
    else if ([elementName isEqualToString:@"exercise"]) {
        if (parentElement != nil)
        {
            currentElement = [[NSString alloc] init];
            currentElement = elementName;
        }
    }
    else if ([elementName isEqualToString:@"image"]) {
        if (parentElement != nil)
        {
            currentElement = [[NSString alloc] init];
            currentElement = elementName;
        }
    }
    else if ([elementName isEqualToString:@"video"]) {
        if (parentElement != nil)
        {
            currentElement = [[NSString alloc] init];
            currentElement = elementName;
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (parentElement != nil)
    {
        if ([parentElement isEqualToString:@"workout"]) {
            if ([currentElement isEqualToString:@"exercise"]) {
                if ([string rangeOfString:@"\n"].location == NSNotFound){
                    [arrayTitles addObject:string];
                }
            }
            else if ([currentElement isEqualToString:@"image"]) {
                if ([string rangeOfString:@"\n"].location == NSNotFound){
                    [arrayImages addObject:string];
                }
            }
            else if ([currentElement isEqualToString:@"video"]) {
                if ([string rangeOfString:@"\n"].location == NSNotFound){
                    [arrayVideos addObject:string];
                }
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExerciseCell *cell = (ExerciseCell *)[tableView dequeueReusableCellWithIdentifier:@"exerciseCell"];
    
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    
    NSString *currentTitle = [arrayTitles objectAtIndex:indexPath.row];
    NSString *currentImage = [arrayImages objectAtIndex:indexPath.row];
    NSString *currentVideo = [arrayVideos objectAtIndex:indexPath.row];
    
    NSString *fixedImagedLink = [currentImage substringFromIndex:20];
    NSString *fixedVideoLink = [currentVideo substringFromIndex:1];
    
    cell.exerciseVideoURL = fixedVideoLink;
    
    [cell beginExerciseImage:fixedImagedLink];
    
    cell.exerciseTitle.font = [UIFont fontWithName:@"System" size:14.0];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.backgroundColor = [UIColor clearColor];
    cell.exerciseTitle.text = currentTitle;
    
    if ([[UIDevice currentDevice].model hasPrefix:@"iPhone"])
    {
        [cell sizeToFitFixedWidth:215.0f];
    }
    else
    {
        [cell sizeToFitFixedWidth:450.0f];
    }
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ExerciseCell *cell = (ExerciseCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSURL *videoURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@", "http://www.gonzoworkout.com", cell.exerciseVideoURL]];
    
    [mediaPlayer setContentURL:videoURL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlaybackComplete:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:mediaPlayer];
    
    [self.view addSubview:mediaPlayer.view];
    [mediaPlayer setFullscreen:YES animated:NO];
    [mediaPlayer prepareToPlay];
    [mediaPlayer play];
}

- (void)moviePlaybackComplete:(NSNotification *)notification
{
    mediaPlayer = [notification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:mediaPlayer];
    
    [mediaPlayer.view removeFromSuperview];
    
    [mediaPlayer stop];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayTitles count];
}

@end
