//
//  IdeaView.h
//  BalloonsCooperation
//
//  Created by Stephanie Ta on 18.01.14.
//  Copyright (c) 2014 Stephanie Ta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IdeaView : UIView

@property (nonatomic, strong) NSLayoutConstraint *balloonWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *balloonHeightConstraint;

- (CGPoint)calculateNewIdeaPosition;
- (void)drawDotAtPoint:(CGPoint)point withImage:(UIImage *)image;

@end
