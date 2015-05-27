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
#import "Models/CampusModel.h"

@interface LoadViewController : UIViewController <CLLocationManagerDelegate>

@property(nonatomic, strong) CampusModel* nearestCampus;
@property(nonatomic, strong) NSArray* campusList;

-(void) doLoad;

@end

