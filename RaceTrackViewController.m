//
//  RaceTrackViewController.m
//  CALayerAnimTest
//
//  Created by Michael Nachbaur on 10-11-28.
//  Copyright 2010 Decaf Ninja Software. All rights reserved.
//

#import "RaceTrackViewController.h"
#import <QuartzCore/QuartzCore.h>

#define degreesToRadians(x) (M_PI * x / 180.0)
#define P(x,y) CGPointMake(x, y)
#define MOVIE_DURATION 21.0
#define POINT_DURATION 3.0


@implementation RaceTrackViewController

@synthesize car;
@synthesize trackPath;
@synthesize trackPath1;
@synthesize trackPath2;

- (void)loadView {
	[super loadView];
	
	self.view.backgroundColor = [UIColor greenColor];	

	self.trackPath = [UIBezierPath bezierPath];
    
	[self.trackPath moveToPoint:P(160, 25)];
	[self.trackPath addCurveToPoint:P(300, 120)
				 controlPoint1:P(320, 0)
				 controlPoint2:P(300, 80)];
    
	[self.trackPath addCurveToPoint:P(80, 380)
				 controlPoint1:P(300, 200)
				 controlPoint2:P(200, 480)];
    
	[self.trackPath addCurveToPoint:P(140, 300)
				 controlPoint1:P(0, 300)
				 controlPoint2:P(200, 220)];
    
	[self.trackPath addCurveToPoint:P(210, 200)
				 controlPoint1:P(30, 420)
				 controlPoint2:P(280, 300)];
    
	[self.trackPath addCurveToPoint:P(70, 110)
				 controlPoint1:P(110, 80)
				 controlPoint2:P(110, 80)];
    
	[self.trackPath addCurveToPoint:P(160, 25)
				 controlPoint1:P(0, 160)
				 controlPoint2:P(0, 40)];

    self.trackPath1 = [UIBezierPath bezierPath];
    [self.trackPath1 moveToPoint:P(80, 380)];
    [self.trackPath1 addCurveToPoint:P(140, 300)
                  controlPoint1:P(0, 300)
                  controlPoint2:P(200, 220)];
    [self.trackPath1 addCurveToPoint:P(210, 200)
                  controlPoint1:P(30, 420)
                  controlPoint2:P(280, 300)];
    [self.trackPath1 addCurveToPoint:P(70, 110)
                  controlPoint1:P(110, 80)
                  controlPoint2:P(110, 80)];
    [self.trackPath1 addCurveToPoint:P(160, 25)
                  controlPoint1:P(0, 160)
                       controlPoint2:P(0, 40)];
    
    self.trackPath2 = [UIBezierPath bezierPath];
    [self.trackPath2 moveToPoint:P(210, 200)];;
    [self.trackPath2 addCurveToPoint:P(70, 110)
                  controlPoint1:P(110, 80)
                  controlPoint2:P(110, 80)];
    [self.trackPath2 addCurveToPoint:P(160, 25)
                  controlPoint1:P(0, 160)
                  controlPoint2:P(0, 40)];
	
	CAShapeLayer *racetrack = [CAShapeLayer layer];
	racetrack.path = trackPath.CGPath;
	racetrack.strokeColor = [UIColor blackColor].CGColor;
	racetrack.fillColor = [UIColor clearColor].CGColor;
	racetrack.lineWidth = 30.0;
	[self.view.layer addSublayer:racetrack];

	CAShapeLayer *centerline = [CAShapeLayer layer];
	centerline.path = trackPath.CGPath;
	centerline.strokeColor = [UIColor whiteColor].CGColor;
	centerline.fillColor = [UIColor clearColor].CGColor;
	centerline.lineWidth = 2.0;
	centerline.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:6], [NSNumber numberWithInt:2], nil];
	[self.view.layer addSublayer:centerline];
	
    CALayer *startPoint = [CALayer layer];
    startPoint.bounds = CGRectMake(0, 0, 20, 20);
    startPoint.position = CGPointMake(160, 25);
    startPoint.cornerRadius = 10;
    startPoint.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:startPoint];
    
	self.car = [CALayer layer];
	car.bounds = CGRectMake(0, 0, 44.0, 20.0);
	car.position = P(160, 25);
	car.contents = (id)([UIImage imageNamed:@"carmodel.png"].CGImage);
	[self.view.layer addSublayer:car];
	
	
}

- (void)raceAt:(NSInteger)point
{
    switch (point) {
        case 0: {
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            anim.path = self.trackPath.CGPath;
            anim.rotationMode = kCAAnimationRotateAuto;
            //	anim.repeatCount = HUGE_VALF;
            anim.duration = MOVIE_DURATION;
            [self.car addAnimation:anim forKey:@"race"];
            break;
        }
        case 1: {
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            anim.path = self.trackPath.CGPath;
            anim.rotationMode = kCAAnimationRotateAuto;
            //	anim.repeatCount = HUGE_VALF;
            anim.duration = MOVIE_DURATION - POINT_DURATION;
            [self.car addAnimation:anim forKey:@"race"];
            break;
        }
        case 2: {
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            anim.path = self.trackPath.CGPath;
            anim.rotationMode = kCAAnimationRotateAuto;
            //	anim.repeatCount = HUGE_VALF;
            anim.duration = MOVIE_DURATION - POINT_DURATION*2;
            [self.car addAnimation:anim forKey:@"race"];
            break;
        }

        default:
            break;
    }
}



@end
