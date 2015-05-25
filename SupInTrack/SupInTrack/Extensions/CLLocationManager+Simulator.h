//
//  CLLocationManager+Simulator.h
//  SupInTrack
//
//  Created by Alvin Meimoun on 25/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#ifndef SupInTrack_CLLocationManager_Simulator_h
#define SupInTrack_CLLocationManager_Simulator_h

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

#ifdef TARGET_IPHONE_SIMULATOR

//Extension permettant de définir une position par défaut sur le simulateur iOS
@interface CLLocationManager (Simulator)
@end

#endif

#endif
