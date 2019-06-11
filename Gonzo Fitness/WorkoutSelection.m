//
//  WorkoutSelection.m
//  Gonzo Fitness
//
//  Created by Joe Ginley on 1/8/13.
//  Copyright (c) 2013 Gonzo Fitness. All rights reserved.
//

#import "WorkoutSelection.h"

#import "ExerciseSelection.h"

#import "AppDelegate.h"

#import "SettingsView.h"

#import "SettingsView-iPad.h"

@implementation WorkoutSelection
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
    self.title = @"Gonzo Workouts";
    
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
    [settingsButton setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
	// Do any additional setup after loading the view, typically from a nib.
    arrayWorkouts = [[NSMutableArray alloc] init];
    [arrayWorkouts addObject:@"Perform 2 Cycles of Each Workout"];
    //[arrayWorkouts addObject:@"SKIP"];
    workoutTV.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
	if ([arrayWorkouts count] == 1) {
        NSString *path = [[NSBundle mainBundle] pathForResource: @"configworkout" ofType:@"xml"];
		NSURL *xmlurl = [NSURL fileURLWithPath:path];
        xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlurl];
        [xmlParser setDelegate:self];
        [xmlParser setShouldProcessNamespaces:NO];
        [xmlParser setShouldReportNamespacePrefixes:NO];
        [xmlParser setShouldResolveExternalEntities:NO];
        [xmlParser parse];
        
        [workoutTV reloadData];
	}
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)settingsClicked
{
    
    backButton = [[UIBarButtonItem alloc] initWithTitle: @"Workouts" style:UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    
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
        NSString *workoutExercises = [attributeDict objectForKey:@"exercises"];
        NSString *finalworkoutName = [NSString alloc];
        if ([workoutID intValue] == 16)
        {
             finalworkoutName = [NSString stringWithFormat:@"%s", "Stretch Session"];
        }
        else
        {
             finalworkoutName = [NSString stringWithFormat:@"%s%s%@", "Workout ", " ", workoutID];
        }
        NSString *finalworkoutExercise = [NSString stringWithFormat:@"%@%s", workoutExercises, " Exercises"];
        [arrayWorkouts addObject:finalworkoutName];
        [arrayWorkouts addObject:finalworkoutExercise];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *workoutNumberString = [NSString stringWithFormat:@"%ld",(long)cell.tag];

    appDel.CurrentWorkoutNumberString = workoutNumberString;
    
    appDel.CurrentWorkoutExerciseNumberString = cell.textLabel.text;
    
    backButton = [[UIBarButtonItem alloc] initWithTitle: @"Workouts" style:UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    
    ExerciseSelection *screen = [[ExerciseSelection alloc] initWithNibName:@"ExerciseSelection" bundle:nil];
    [self.navigationController pushViewController:screen animated:YES];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)path
{
    NSString *currentWorkout = [arrayWorkouts objectAtIndex:path.row];
    
    if ([currentWorkout rangeOfString:@"Workout"].location == NSNotFound && [currentWorkout rangeOfString:@"Perform"].location == NSNotFound && [currentWorkout rangeOfString:@"Stretch"].location == NSNotFound)
    {
        return path;
    }
    else
    {
        return nil;
    }
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
	
	UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	headerLabel.backgroundColor = [UIColor clearColor];
	headerLabel.opaque = NO;
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.highlightedTextColor = [UIColor whiteColor];
	headerLabel.font = [UIFont boldSystemFontOfSize:20];
	headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 44.0);
    
    headerLabel.text = [arrayExercises objectAtIndex:section];
    
	[customView addSubview:headerLabel];
    
	return customView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [arrayWorkouts count];
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *tableIdentifier = @"tcellidentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    NSString *currentWorkout = [arrayWorkouts objectAtIndex:indexPath.row];
    
    if ([currentWorkout rangeOfString:@"Workout"].location != NSNotFound)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
    }
    else if ([currentWorkout rangeOfString:@"Stretch"].location != NSNotFound)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
    }
    else if ([currentWorkout rangeOfString:@"Perform"].location != NSNotFound)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
    }
    else
    {
        NSString *currentWorkoutName = [arrayWorkouts objectAtIndex:indexPath.row-1];
        if ([currentWorkoutName isEqualToString:@"Stretch Session"])
        {
            cell.tag = 16;
        }
        else
        {
            NSArray* workoutSplit = [currentWorkoutName componentsSeparatedByString:@" "];
            int workoutNumber = [workoutSplit[2] intValue];
            cell.tag = workoutNumber;
        }
                
        cell.textLabel.font = [UIFont fontWithName:@"System" size:12.0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = currentWorkout;
    
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayWorkouts count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *currentWorkout = [arrayWorkouts objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = (UITableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if ([currentWorkout rangeOfString:@"Perform"].location != NSNotFound)
    {
        return cell.contentView.frame.size.height + 10;
    }
    else
    {
        return cell.contentView.frame.size.height;
    }
}

@end
