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

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic) NSInteger counter;

@property (nonatomic, strong) NSDate *start;
@property (nonatomic, strong) NSDate *stop;

- (void)logDataFromAirPump:(AirPumpView *)airpump;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.currentBalloonHeight = 10.0f;
    
    // Log start of user study
    
    self.counter = 1;
    self.start = [NSDate date];
    
    /* Comment this out when you start the app on your device
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *docsDirectory = [paths objectAtIndex:0];
     NSString *path = [docsDirectory stringByAppendingPathComponent:@"dataLoggingFromDevice_cooperate.txt"];
     */
    
//    /* Comment this out when you start the app on the simulator, CHANGE "yourUsername" in path to your username!!!
    NSString *path = @"/Users/yourUsername/Desktop/dataLoggingFromSimulator_cooperate.txt";
//    */
    
    /* use following code of line to remove the file */
//    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    
    /* use the three following lines to create a file if not already existing */
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    }
    
    NSString *message = @"\n***** Start of new user study: Model Cooperation *****\n\n";
    NSFileHandle *logFile = [NSFileHandle fileHandleForUpdatingAtPath:path];
    [logFile seekToEndOfFile];
    [logFile writeData:[message dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Set up cloud view
    
    self.cloudView = [[CloudView alloc] init];
    self.cloudView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.cloudView];
    [self.cloudView animateCloudView];
    
    // Set up ground view
    
    UIImageView *grasslandView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grassland.png"]];
    grasslandView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:grasslandView];
    
    // Set up idea view
    
    self.ideaView = [[IdeaView alloc] init];
    self.ideaView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.cloudView addSubview:self.ideaView];
    
    // Set up air tubes
    
    self.airTubeLeft = [[AirTubeView alloc] init];
    self.airTubeLeft.translatesAutoresizingMaskIntoConstraints = NO;
    [self.airTubeLeft drawAirTubeAtPosition:@"Left"];
    [self.view addSubview:self.airTubeLeft];
    
    self.airTubeCenter = [[AirTubeView alloc] init];
    self.airTubeCenter.translatesAutoresizingMaskIntoConstraints = NO;
    [self.airTubeCenter drawAirTubeAtPosition:@"Center"];
    [self.view addSubview:self.airTubeCenter];
    
    self.airTubeRight = [[AirTubeView alloc] init];
    self.airTubeRight.translatesAutoresizingMaskIntoConstraints = NO;
    [self.airTubeRight drawAirTubeAtPosition:@"Right"];
    [self.view addSubview:self.airTubeRight];
    
    // Set up air pumps
    
    self.airPumpOne = [[AirPumpView alloc] init];
    self.airPumpOne.translatesAutoresizingMaskIntoConstraints = NO;
    self.airPumpOne.identification = @"Links";
    self.airPumpOne.delegate = self;
    [self.view addSubview:self.airPumpOne];
    
    self.airPumpTwo = [[AirPumpView alloc] init];
    self.airPumpTwo.translatesAutoresizingMaskIntoConstraints = NO;
    self.airPumpTwo.identification = @"Mitte";
    self.airPumpTwo.delegate = self;
    [self.view addSubview:self.airPumpTwo];
    
    self.airPumpThree = [[AirPumpView alloc] init];
    self.airPumpThree.translatesAutoresizingMaskIntoConstraints = NO;
    self.airPumpThree.identification = @"Rechts";
    self.airPumpThree.delegate = self;
    [self.view addSubview:self.airPumpThree];
    
    // Layout views
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_cloudView, grasslandView, _ideaView, _airPumpOne, _airPumpTwo, _airPumpThree, _airTubeLeft, _airTubeCenter, _airTubeRight);
    
    // Background views
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cloudView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_cloudView(200.0)]" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[grasslandView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[grasslandView]|" options:0 metrics:nil views:views]];
    
    // Idea view
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
    
    // AirPumps
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-85.0-[_airPumpOne(40.0)]-120.0-[_airPumpTwo(_airPumpOne)]-160.0-[_airPumpThree(==_airPumpOne)]" options:(NSLayoutFormatAlignAllBottom | NSLayoutFormatAlignAllTop) metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airPumpOne(70.0)]-20.0-|" options:0 metrics:nil views:views]];
    
    // AirTubes
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-65.0-[_airTubeLeft(210.0)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airTubeLeft(115.0)]-22.0-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-225.0-[_airTubeCenter(125.0)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airTubeCenter(115.0)]-22.0-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-290.0-[_airTubeRight(220.0)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_airTubeRight(115.0)]-22.0-|" options:0 metrics:nil views:views]];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - airPump delegate methods

- (void)didTapOnAirPump:(UIView *)airPumpView {
    
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        CGPoint position = [self.ideaView calculateNewIdeaPosition];
        [self.ideaView drawDotAtPoint:position withImage:[UIImage imageNamed:@"dotLightYellow.png"]];
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            if (self.ideaView.balloonHeightConstraint.constant > self.currentBalloonHeight) {
                self.currentBalloonHeight = self.ideaView.balloonHeightConstraint.constant;
                self.ideaViewPositionYConstraint.constant -= 10.0f;
                [self.view setNeedsUpdateConstraints];
                
                [UIView animateWithDuration:0.5f animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
        }];
        [CATransaction commit];
    };
    
    if ([airPumpView isEqual:self.airPumpOne]) {
        [self.airTubeLeft animateIdeaAlongAirTubeAtPosition:@"Left" completion:completionBlock];
        [self logDataFromAirPump:self.airPumpOne];
    }
    else if ([airPumpView isEqual:self.airPumpTwo]) {
        [self.airTubeCenter animateIdeaAlongAirTubeAtPosition:@"Center" completion:completionBlock];
        [self logDataFromAirPump:self.airPumpTwo];
    }
    else if ([airPumpView isEqual:self.airPumpThree]) {
        [self.airTubeRight animateIdeaAlongAirTubeAtPosition:@"Right" completion:completionBlock];
        [self logDataFromAirPump:self.airPumpThree];
    }
}

- (void)logDataFromAirPump:(AirPumpView *)airpump {
    
    // Berechnung der Uhrzeit
    
    self.date = [NSDate date];
    self.calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [self.calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:self.date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger second = [components second];
    
    // Berechnung der Zeitdauer
    
    self.stop = [NSDate date];
    NSTimeInterval timeIntervall = [self.stop timeIntervalSinceDate:self.start];
    int timeIntervallMinutes = (int)floor(timeIntervall/60.0f);
    int timeIntervallSeconds = (int)round(timeIntervall - timeIntervallMinutes * 60.0f);
    NSString *timeIntervallString = [NSString stringWithFormat:@"%d:%d", timeIntervallMinutes, timeIntervallSeconds];
    
    // Logging
    
    /* Comment this out when you start the app on your device
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *docsDirectory = [paths objectAtIndex:0];
     NSString *path = [docsDirectory stringByAppendingPathComponent:@"dataLoggingFromDevice_cooperate.txt"];
     */
    
//    /* Comment this out when you start the app on the simulator, CHANGE "yourUsername" in path to your username!!!
    NSString *path = @"/Users/yourUsername/Desktop/dataLoggingFromSimulator_cooperate.txt";
//    */
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    }
    
    NSString *message = [NSString stringWithFormat:@"%d. Uhrzeit: %d:%d:%d, Zeitdauer: %@, Luftpumpe: %@\n", (int)self.counter, (int)hour, (int)minute, (int)second, timeIntervallString, airpump.identification];
    NSFileHandle *logFile = [NSFileHandle fileHandleForUpdatingAtPath:path];
    [logFile seekToEndOfFile];
    [logFile writeData:[message dataUsingEncoding:NSUTF8StringEncoding]];

    self.counter += 1;
}

@end
