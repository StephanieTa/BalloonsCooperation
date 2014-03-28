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
    
    UIImageView *blueSky = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueSky.png"]];
    blueSky.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:blueSky];
    
    self.cloud1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloudBig.png"]];
    self.cloud1.frame = CGRectMake(568.0f, 10.0f, 100.0f, 60.0f);
    [self addSubview:self.cloud1];
    
    self.cloud2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloudSmall.png"]];
    self.cloud2.frame = CGRectMake(-80.0f, 90.0f, 80.0f, 40.0f);
    [self addSubview:self.cloud2];
    
    self.cloud3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloudBig.png"]];
    self.cloud3.frame = CGRectMake(568.0f, 70.0f, 70.0f, 30.0f);
    [self addSubview:self.cloud3];
    
    // Layout
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[blueSky]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(blueSky)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[blueSky]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(blueSky)]];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initCloudView];
    }
    return self;
}

- (void)animateCloudView {
    [self.cloud1.layer removeAllAnimations];
    [self.cloud2.layer removeAllAnimations];
    [self.cloud3.layer removeAllAnimations];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation1.duration = 180.0;
    animation1.beginTime = CACurrentMediaTime() + 3.0;
    animation1.toValue = @-668.0f;
    animation1.repeatCount = INFINITY;
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [self.cloud1.layer addAnimation:animation1 forKey:nil];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation2.duration = 120.0;
    animation2.beginTime = CACurrentMediaTime() + 7.0;
    animation2.toValue = @648.0f;
    animation2.repeatCount = INFINITY;
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [self.cloud2.layer addAnimation:animation2 forKey:nil];
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation3.duration = 150.0;
    animation3.beginTime = CACurrentMediaTime() + 1.0;
    animation3.toValue = @-628.0f;
    animation3.repeatCount = INFINITY;
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [self.cloud3.layer addAnimation:animation3 forKey:nil];
}

@end
