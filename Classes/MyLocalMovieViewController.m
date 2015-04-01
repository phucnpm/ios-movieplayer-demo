/*

    File: MyLocalMovieViewController.m
Abstract: 
Subclass of MyMovieViewController. Gives a URL to a local movie stored in the app bundle. Implements a 'Play Movie' button for playback of a local movie. 
Also plays the local movie on touches to the UIImageView. 

 Version: 1.5

Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
Inc. ("Apple") in consideration of your agreement to the following
terms, and your use, installation, modification or redistribution of
this Apple software constitutes acceptance of these terms.  If you do
not agree with these terms, please do not use, install, modify or
redistribute this Apple software.

In consideration of your agreement to abide by the following terms, and
subject to these terms, Apple grants you a personal, non-exclusive
license, under Apple's copyrights in this original Apple software (the
"Apple Software"), to use, reproduce, modify and redistribute the Apple
Software, with or without modifications, in source and/or binary forms;
provided that if you redistribute the Apple Software in its entirety and
without modifications, you must retain this notice and the following
text and disclaimers in all such redistributions of the Apple Software.
Neither the name, trademarks, service marks or logos of Apple Inc. may
be used to endorse or promote products derived from the Apple Software
without specific prior written permission from Apple.  Except as
expressly stated in this notice, no other rights or licenses, express or
implied, are granted by Apple herein, including but not limited to any
patent rights that may be infringed by your derivative works or by other
works in which the Apple Software may be incorporated.

The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

Copyright (C) 2014 Apple Inc. All Rights Reserved.


*/

#import "MyLocalMovieViewController.h"
#import "MyImageView.h"
#import "RaceTrackViewController.h"

#define DURATION 22

@interface MyLocalMovieViewController (LocalMovieURL)
-(NSURL *)localMovieURL;
@end

#pragma mark -
@implementation MyLocalMovieViewController (LocalMovieURL)

/* Returns a URL to a local movie in the app bundle. */
-(NSURL *)localMovieURL
{
	NSURL *theMovieURL = nil;
	NSBundle *bundle = [NSBundle mainBundle];
	if (bundle) 
	{
		NSString *moviePath = [bundle pathForResource:@"Movie" ofType:@"m4v"];
		if (moviePath)
		{
			theMovieURL = [NSURL fileURLWithPath:moviePath];
		}
	}
    return theMovieURL;
}

@end

#pragma mark -

@implementation MyLocalMovieViewController

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self createAndConfigurePlayerWithURL:[self localMovieURL]  sourceType:MPMovieSourceTypeFile];
    
    RaceTrackViewController* vc = [[RaceTrackViewController alloc] initWithNibName:nil bundle:nil];
    CGRect viewFrame = [self.view bounds];

    if(!IPAD) {
        vc.view.layer.anchorPoint = CGPointMake(0, 0);
        vc.view.layer.sublayerTransform = CATransform3DMakeScale(0.5, 0.5, 0.0);
    }
    vc.view.frame = CGRectMake(0, 0, viewFrame.size.width/2.0, viewFrame.size.height/2.0);
    
    [self.view addSubview:vc.view];

    self.imageView0.image = [[self moviePlayerController] thumbnailImageAtTime:0
                                                                    timeOption:MPMovieTimeOptionNearestKeyFrame];
    self.imageView0.startSecond = [NSNumber numberWithFloat:0];
    self.imageView0.raceController = vc;
    
    self.imageView5.image = [[self moviePlayerController] thumbnailImageAtTime:4
                                                   timeOption:MPMovieTimeOptionNearestKeyFrame];
    self.imageView5.startSecond = [NSNumber numberWithFloat:4];
    self.imageView5.raceController = vc;
    
    self.imageView10.image = [[self moviePlayerController] thumbnailImageAtTime:12
                                                                    timeOption:MPMovieTimeOptionNearestKeyFrame];
    self.imageView10.startSecond = [NSNumber numberWithFloat:12];
    self.imageView10.raceController = vc;

    
    [[self moviePlayerController] pause];
    [self.view bringSubviewToFront:self.currentTimeLbl];
}

-(void)monitorPlaybackTime
{
    float time = [self moviePlayerController].currentPlaybackTime;
    [self.currentTimeLbl setText:[NSString stringWithFormat:@"%.2f s", time]];
//    NSLog(@"currenttime: %f", time);
    
    //keep checking for the end of video
    if(time < DURATION){
        [self performSelector:@selector(monitorPlaybackTime) withObject:nil afterDelay:0.1];
    }
    
}

/* Button presses for the 'Play Movie' button. */
-(IBAction)playMovieButtonPressed:(id)sender
{
	/* Play the movie at the specified URL. */
    [self playMovieFile:[self localMovieURL]];
}

-(void)playMovieAt:(float)second
{
    /* Play the movie at the specified URL. */
    [[self moviePlayerController] pause];

    [[self moviePlayerController] setCurrentPlaybackTime:second];
//    [self playMovieFile:[self localMovieURL]];
    
    [self performSelector:@selector(playMovie) withObject:NULL afterDelay:0.1];
    [self monitorPlaybackTime];
}

-(void)playMovie
{
    [[self moviePlayerController] play];
}


@end
