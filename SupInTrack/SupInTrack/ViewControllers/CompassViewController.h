//
//  CompassViewController.h
//  SupInTrack
//
//  Created by Alvin Meimoun on 26/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#ifndef SupInTrack_CompassViewController_h
#define SupInTrack_CompassViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "../Models/CampusModel.h"
#import "../LoadViewController.h"

@interface CompassViewController : UIViewController <CLLocationManagerDelegate>

-(void) bindCampus:(CampusModel*)model;

@end


#endif
