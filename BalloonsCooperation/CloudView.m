//
//  CloudView.m
//  BalloonsCooperation
//
//  Created by Stephanie Ta on 18.01.14.
//  Copyright (c) 2014 Stephanie Ta. All rights reserved.
//

#import "CloudView.h"

@interface CloudView ()

@property (nonatomic, strong) UIImageView *cloud1;
@property (nonatomic, strong) UIImageView *cloud2;
@property (nonatomic, strong) UIImageView *cloud3;

- (void)initCloudView;

@end


@implementation CloudView

- (void)initCloudView {
    
    // Set up views
    
    UIImageView *cloudBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloudBG.jpg"]];
    cloudBG.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:cloudBG];
    
    self.cloud1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloudBig.png"]];
    self.cloud1.frame = CGRectMake(480.0f, 10.0f, 100.0f, 60.0f);
    [self addSubview:self.cloud1];
    
    self.cloud2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloudSmall.png"]];
    self.cloud2.frame = CGRectMake(-80.0f, 90.0f, 80.0f, 40.0f);
    [self addSubview:self.cloud2];
    
    self.cloud3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloudBig.png"]];
    self.cloud3.frame = CGRectMake(480.0f, 70.0f, 70.0f, 30.0f);
    [self addSubview:self.cloud3];
    
    // Layout
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[cloudBG]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(cloudBG)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cloudBG]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(cloudBG)]];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initCloudView];
    }
    return self;
}

- (void)animateCloudView {
    [UIImageView animateWithDuration:180.0f
                               delay:3.0f
                             options:(UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseIn)
                          animations:^{
                              self.cloud1.transform = CGAffineTransformMakeTranslation(-580.0f, 0);
                          } completion:NULL];
    
    [UIImageView animateWithDuration:120.0f
                               delay:7.0f
                             options:(UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseIn)
                          animations:^{
                              self.cloud2.transform = CGAffineTransformMakeTranslation(560.0f, 0);
                          } completion:NULL];
    
    [UIImageView animateWithDuration:150.0f
                               delay:10.0f
                             options:(UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseIn)
                          animations:^{
                              self.cloud3.transform = CGAffineTransformMakeTranslation(-580.0f, 0);
                          } completion:NULL];
}

@end
