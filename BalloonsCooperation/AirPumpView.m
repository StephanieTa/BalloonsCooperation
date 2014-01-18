//
//  AirPumpView.m
//  BalloonsCooperation
//
//  Created by Stephanie Ta on 18.01.14.
//  Copyright (c) 2014 Stephanie Ta. All rights reserved.
//

#import "AirPumpView.h"

@interface AirPumpView ()

@property (nonatomic, strong) UIImageView *bottomView;
@property (nonatomic, strong) UIImageView *topView;

- (void)initAirPump;
- (void)onAirPumpTouchUpInside:(id)sender;

@end

@implementation AirPumpView

- (void)initAirPump {
    
    // Set up air pump top
    
    self.topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"airPumpTop.png"]];
    self.topView.frame = CGRectMake(5.0f, 5.0f, 30.0f, 20.0f);
    [self addSubview:self.topView];
    
    // Set up air pump bottom
    
    self.bottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"airPumpBottomRed.png"]];
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.bottomView];
    
    // Layout
    NSDictionary *views = NSDictionaryOfVariableBindings(_topView, _bottomView);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bottomView(40.0)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomView(50.0)]|" options:0 metrics:nil views:views]];
    
    // Actions
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAirPumpTouchUpInside:)];
    [self addGestureRecognizer:tapGesture];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = nil;
        self.opaque = NO;
        [self initAirPump];
    }
    return self;
}

#pragma mark - Private methods

- (void)onAirPumpTouchUpInside:(id)sender {
    [UIView animateWithDuration:0.5f
                     animations:^{
                         self.topView.frame = CGRectMake(5.0f, 15.0f, 30.0f, 20.0f);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5f
                                          animations:^{
                                              self.topView.frame = CGRectMake(5.0f, 5.0f, 30.0f, 20.0f);
                                          }
                          ];
                         [self.delegate didTapOnAirPump:self];
                     }
     ];
}

@end
