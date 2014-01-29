//
//  AirTubeView.h
//  BalloonsCooperation
//
//  Created by Stephanie Ta on 18.01.14.
//  Copyright (c) 2014 Stephanie Ta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirTubeView : UIView

@property (nonatomic) NSString *identification;

- (void)drawAirTubeAtPosition:(NSString *)position;
- (void)animateIdeaAlongAirTubeAtPosition:(NSString *)position completion:(void (^)(BOOL finished))completionBlock;

@end
