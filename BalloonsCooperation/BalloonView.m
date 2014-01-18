//
//  BalloonView.m
//  BalloonsCooperation
//
//  Created by Stephanie Ta on 18.01.14.
//  Copyright (c) 2014 Stephanie Ta. All rights reserved.
//

#import "BalloonView.h"

@interface BalloonView ()

- (void)initBallon;

@end

@implementation BalloonView

- (void)initBallon {
    //    UIGraphicsBeginImageContext(CGSizeMake(100.0f, 100.0f));
    //
    //    UIBezierPath *balloonPath = [UIBezierPath balloonGlyph];
    //    [balloonPath applyTransform:CGAffineTransformMakeScale(1.7f, 1.7f)];
    //    [balloonPath applyTransform:CGAffineTransformMakeTranslation(15.0f, 0)];
    //    [[UIColor blackColor] setStroke];
    //    [balloonPath stroke];
    //    [[UIColor whiteColor] setFill];
    //    [balloonPath fill];
    //
    //    UIImage *balloonImage = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    
    UIImageView *balloonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Balloon.png"]];
    balloonImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:balloonImageView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[balloonImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(balloonImageView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[balloonImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(balloonImageView)]];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initBallon];
        self.backgroundColor = nil;
        self.opaque = NO;
    }
    return self;
}

@end
