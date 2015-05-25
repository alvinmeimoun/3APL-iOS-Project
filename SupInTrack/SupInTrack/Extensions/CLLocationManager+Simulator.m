//
//  CLLocationManager+Simulator.m
//  SupInTrack
//
//  Created by Alvin Meimoun on 25/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#import "CLLocationManager+Simulator.h"

#ifdef TARGET_IPHONE_SIMULATOR

@implementation CLLocationManager (Simulator)

-(void)startUpdatingLocation {
    CLLocation *defaultLocation = [[CLLocation alloc] initWithLatitude:43.703130 longitude:7.266080];
    [self.delegate locationManager:self
               didUpdateLocations:[[NSArray alloc] initWithObjects:defaultLocation, nil]];
}

@end

#endif