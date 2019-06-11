//
//  ExerciseCell.h
//  Gonzo Fitness
//
//  Created by Joe Ginley on 1/15/13.
//  Copyright (c) 2013 Gonzo Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseCell : UITableViewCell
{
    UIImageView *exerciseImage;
    UILabel *exerciseTitle;
    
    NSString *exerciseImageURL;
}

@property (nonatomic, retain) IBOutlet UIImageView *exerciseImage;
@property (nonatomic, retain) IBOutlet UILabel *exerciseTitle;

@property (nonatomic, retain) NSString *exerciseVideoURL;
@property (nonatomic, retain) NSString *exerciseImageURL;

- (void)beginExerciseImage:(NSString *)imageURL;
- (void)sizeToFitFixedWidth:(CGFloat)fixedWidth;

@end
