//
//  ExerciseCell.m
//  Gonzo Fitness
//
//  Created by Joe Ginley on 1/15/13.
//  Copyright (c) 2013 Gonzo Fitness. All rights reserved.
//

#import "ExerciseCell.h"

#import <QuartzCore/QuartzCore.h>

@implementation ExerciseCell

@synthesize exerciseImage;
@synthesize exerciseTitle;

@synthesize exerciseImageURL;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)beginExerciseImage:(NSString *)imageURL
{
    self.exerciseImageURL = imageURL;
    
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:@selector(InitExerciseImage)
                                        object:nil];
    [queue addOperation:operation];
}

- (void)sizeToFitFixedWidth:(CGFloat)fixedWidth
{
    self.exerciseTitle.frame = CGRectMake(self.exerciseTitle.frame.origin.x, self.exerciseTitle.frame.origin.y, fixedWidth, 0);
    self.exerciseTitle.lineBreakMode = NSLineBreakByWordWrapping;
    self.exerciseTitle.numberOfLines = 0;
    [self.exerciseTitle sizeToFit];
}

- (void)InitExerciseImage
{
    NSString *absolutePath = [[[NSBundle mainBundle] resourcePath]  stringByAppendingPathComponent:self.exerciseImageURL];
    NSData *imageData = [[NSData alloc] initWithContentsOfFile:absolutePath];
    if (imageData.length > 0)
    {
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        dispatch_async(dispatch_get_main_queue(),^ {
            [self.exerciseImage setImage:image];
            self.exerciseImage.layer.cornerRadius = 5.0;
            self.exerciseImage.layer.masksToBounds = YES;
            //self.exerciseImage.layer.borderWidth = 1.0;
            //self.exerciseImage.layer.borderColor = [UIColor colorWithRed:0xE6/255.0 green:0xE6/255.0 blue:0xE6/255.0 alpha:1].CGColor;
        });
    }
}

@end
