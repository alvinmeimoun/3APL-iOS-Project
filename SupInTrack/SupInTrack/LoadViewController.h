//
//  ViewController.h
//  SupInTrack
//
//  Created by Alvin Meimoun on 22/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Extensions/CLLocationManager+Simulator.h"

@interface LoadViewController : UIViewController <CLLocationManagerDelegate>

-(void) doLoad;

@end

