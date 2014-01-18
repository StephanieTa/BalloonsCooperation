//
//  IdeaView.m
//  BalloonsCooperation
//
//  Created by Stephanie Ta on 18.01.14.
//  Copyright (c) 2014 Stephanie Ta. All rights reserved.
//

#import "IdeaView.h"
#import "BalloonView.h"

static CGFloat const balloonSize = 100.0f;
static CGFloat const dotSize = 10.0f;


@interface IdeaView ()

@property (nonatomic, strong) BalloonView *balloonView;

@property (nonatomic) NSInteger round;
@property (nonatomic) BOOL yTurn;
@property (nonatomic) NSInteger changeNr;
@property (nonatomic) CGPoint point;

- (void)initIdeaView;

@end


@implementation IdeaView

- (void)initIdeaView {
    
    // Set up balloon view
    
    self.balloonView = [[BalloonView alloc] init];
    [self addSubview:self.balloonView];
    
    // Layout
    
    self.balloonWidthConstraint = [NSLayoutConstraint constraintWithItem:self.balloonView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:10.0f];
    self.balloonHeightConstraint = [NSLayoutConstraint constraintWithItem:self.balloonView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:10.0f];
    [self addConstraints:@[self.balloonWidthConstraint, self.balloonHeightConstraint]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.balloonView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.balloonView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
    
    // Calculation properties
    
    self.round = 0;
    self.yTurn = YES;
    self.changeNr = 1;
    self.point = CGPointMake(balloonSize/2.0f - dotSize/2.0f, balloonSize/2.0f - dotSize/2.0f);
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = nil;
        self.opaque = NO;
        [self initIdeaView];
    }
    return self;
}

#pragma mark - Public methods

- (CGPoint)calculateNewIdeaPosition {
    CGPoint point = self.point;
    
    // Calculate point at where to add new idea
    
    if (self.round == 0) {
        self.round++;
    }
    else {
        if (self.round % 2 == 1) {
            if (self.yTurn) {
                point.y = point.y - 10.0f;
                if (self.changeNr == self.round) {
                    self.yTurn = NO;
                }
                self.changeNr++;
            }
            else {
                point.x = point.x - 10.0f;
                if (self.changeNr == self.round * 2) {
                    self.yTurn = YES;
                    self.changeNr = 1;
                    self.round++;
                }
                else {
                    self.changeNr++;
                }
            }
        }
        else if (self.round % 2 == 0) {
            if (self.yTurn) {
                point.y = point.y + 10.0f;
                if (self.changeNr == self.round) {
                    self.yTurn = NO;
                }
                self.changeNr++;
            }
            else {
                point.x = point.x + 10.0f;
                if (self.changeNr == self.round * 2) {
                    self.yTurn = YES;
                    self.changeNr = 1;
                    self.round++;
                }
                else {
                    self.changeNr++;
                }
            }
        }
        self.point = point;
    }
    return self.point;
}

- (void)drawDotAtPoint:(CGPoint)point withImage:(UIImage *)image {
    UIImageView *dotImageView = [[UIImageView alloc] initWithImage:image];
    dotImageView.alpha = 0;
    dotImageView.frame = CGRectMake(point.x + 5.0f, point.y + 10.0f, 8.0f, 8.0f);
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [UIView animateWithDuration:0.5f animations:^{
            dotImageView.alpha = 1.0f;
            dotImageView.frame = CGRectMake(point.x, point.y, 8.0f, 8.0f);
            
            // Recalculate balloonView size
            CGFloat widthCount = ceilf(sqrtf(self.subviews.count - 1));
            self.balloonWidthConstraint.constant = dotSize * widthCount * 2.0f;
            self.balloonHeightConstraint.constant = dotSize * widthCount * 2.0f;
        }];
    }];
    
    [self addSubview:dotImageView];
    [CATransaction commit];
}

@end
