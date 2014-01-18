//
//  ViewController.m
//  BalloonsCooperation
//
//  Created by Stephanie Ta on 18.01.14.
//  Copyright (c) 2014 Stephanie Ta. All rights reserved.
//

#import "ViewController.h"

#import "AirTubeView.h"
#import "BalloonView.h"
#import "CloudView.h"
#import "IdeaView.h"


@interface ViewController ()

@property (nonatomic, strong) AirPumpView *airPumpOne;
@property (nonatomic, strong) AirPumpView *airPumpTwo;
@property (nonatomic, strong) AirPumpView *airPumpThree;

@property (nonatomic, strong) AirTubeView *airTubeLeft;
@property (nonatomic, strong) AirTubeView *airTubeCenter;
@property (nonatomic, strong) AirTubeView *airTubeRight;

@property (nonatomic, strong) IdeaView *ideaView;
@property (nonatomic, strong) CloudView *cloudView;

@property (nonatomic, strong) NSLayoutConstraint *ideaViewPositionYConstraint;
@property (nonatomic, assign) CGFloat currentBalloonHeight;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentBalloonHeight = 10.0f;
    
    // Set up cloud view
    
    self.cloudView = [[CloudView alloc] init];
    [self.view addSubview:self.cloudView];
    [self.cloudView animateCloudView];
    
    // Set up ground view
    
    UIImageView *groundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenBG.png"]];
    groundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:groundView];
    
    // Set up idea view
    
    self.ideaView = [[IdeaView alloc] init];
    [self.cloudView addSubview:self.ideaView];
    
    // Set up air tubes
    
    self.airTubeLeft = [[AirTubeView alloc] init];
    [self.airTubeLeft drawAirTubeAtPosition:@"Left"];
    [self.view addSubview:self.airTubeLeft];
    
    self.airTubeCenter = [[AirTubeView alloc] init];
    [self.airTubeCenter drawAirTubeAtPosition:@"Center"];
    [self.view addSubview:self.airTubeCenter];
    
    self.airTubeRight = [[AirTubeView alloc] init];
    [self.airTubeRight drawAirTubeAtPosition:@"Right"];
    [self.view addSubview:self.airTubeRight];
    
    // Set up air pumps
    
    self.airPumpOne = [[AirPumpView alloc] init];
    self.airPumpOne.delegate = self;
    [self.view addSubview:self.airPumpOne];
    
    self.airPumpTwo = [[AirPumpView alloc] init];
    self.airPumpTwo.delegate = self;
    [self.view addSubview:self.airPumpTwo];
    
    self.airPumpThree = [[AirPumpView alloc] init];
    self.airPumpThree.delegate = self;
    [self.view addSubview:self.airPumpThree];
    
    // Layout views
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_cloudView, groundView, _ideaView, _airPumpOne, _airPumpTwo, _airPumpThree, _airTubeLeft, _airTubeCenter, _airTubeRight);
    
    // Background views
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cloudView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_cloudView(200.0)]" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[groundView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[groundView]|" options:0 metrics:nil views:views]];
    
    // Idea views
    [self.cloudView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.ideaView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.cloudView
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0f
                                   constant:0]];
    
    [self.cloudView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.ideaView
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1.0f
                                   constant:100.0f]];
    
    [self.cloudView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.ideaView
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1.0f
                                   constant:100.0f]];
    
    self.ideaViewPositionYConstraint = [NSLayoutConstraint constraintWithItem:self.ideaView
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.cloudView attribute:NSLayoutAttributeBottom
                                                                      multiplier:1.0f
                                                                        constant:20.0f];
    [self.cloudView addConstraints:@[self.ideaViewPositionYConstraint]];
    
    // AirPumps with airtube
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40.0-[_airPumpOne(40.0)]-120.0-[_airPumpTwo(_airPumpOne)]-160.0-[_airPumpThree(==_airPumpOne)]" options:(NSLayoutFormatAlignAllBottom | NSLayoutFormatAlignAllTop) metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airPumpOne(70.0)]-20.0-|" options:0 metrics:nil views:views]];
    
    // AirTubes
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20.0-[_airTubeLeft(210.0)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airTubeLeft(115.0)]-22.0-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-180.0-[_airTubeCenter(125.0)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airTubeCenter(115.0)]-22.0-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-245.0-[_airTubeRight(220.0)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airTubeRight(115.0)]-22.0-|" options:0 metrics:nil views:views]];
}

#pragma mark - airPump delegate methods

- (void)didTapOnAirPump:(UIView *)airPumpView {
    
    void (^completionBlockA)(BOOL) = ^(BOOL finished) {
//        CGPoint position = [self.ideaView calculateNewIdeaPosition];
//        [self.ideaView drawDotAtPoint:position withImage:[UIImage imageNamed:@"blueDot.png"]];
//        
//        [CATransaction begin];
//        [CATransaction setCompletionBlock:^{
//            if (self.ideaView.balloonHeightConstraint.constant > self.currentBalloonHeight) {
//                self.currentBalloonHeight = self.ideaView.balloonHeightConstraint.constant;
//                self.ideaViewPositionYConstraint.constant -= 10.0f;
//            }
//        }];
    };
    
    void (^completionBlockB)(BOOL) = ^(BOOL finished) {
//        CGPoint position = [self.ideaViewTwo calculateNewIdeaPosition];
//        [self.ideaViewTwo drawDotAtPoint:position withImage:[UIImage imageNamed:@"redDot.png"]];
//        
//        [CATransaction begin];
//        [CATransaction setCompletionBlock:^{
//            if (self.ideaViewTwo.balloonHeightConstraint.constant > self.currentHeightBalloonTwo) {
//                self.currentHeightBalloonTwo = self.ideaViewTwo.balloonHeightConstraint.constant;
//                self.ideaViewTwoPositionYConstraint.constant -= 10.0f;
//            }
//        }];
    };
    
    void (^completionBlockC)(BOOL) = ^(BOOL finished) {
//        CGPoint position = [self.ideaViewThree calculateNewIdeaPosition];
//        [self.ideaViewThree drawDotAtPoint:position withImage:[UIImage imageNamed:@"greenDot.png"]];
//        
//        [CATransaction begin];
//        [CATransaction setCompletionBlock:^{
//            if (self.ideaViewThree.balloonHeightConstraint.constant > self.currentHeightBalloonThree) {
//                self.currentHeightBalloonThree = self.ideaViewThree.balloonHeightConstraint.constant;
//                self.ideaViewThreePositionYConstraint.constant -= 10.0f;
//            }
//        }];
    };
    
    if ([airPumpView isEqual:self.airPumpOne]) {
        [self.airTubeLeft animateIdeaAlongAirTubeAtPosition:@"Left" completion:completionBlockA];
    }
    else if ([airPumpView isEqual:self.airPumpTwo]) {
        [self.airTubeCenter animateIdeaAlongAirTubeAtPosition:@"Center" completion:completionBlockB];
    }
    else if ([airPumpView isEqual:self.airPumpThree]) {
        [self.airTubeRight animateIdeaAlongAirTubeAtPosition:@"Right" completion:completionBlockC];
    }
}

@end
