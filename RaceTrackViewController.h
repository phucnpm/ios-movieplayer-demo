//
//  RaceTrackViewController.h
//  CALayerAnimTest
//
//  Created by Michael Nachbaur on 10-11-28.
//  Copyright 2010 Decaf Ninja Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RaceTrackViewController : UIViewController {

}

@property (strong) CALayer *car;
@property (strong) UIBezierPath *trackPath;
@property (strong) UIBezierPath *trackPath1;
@property (strong) UIBezierPath *trackPath2;

- (void)raceAt:(NSInteger)point;

@end
