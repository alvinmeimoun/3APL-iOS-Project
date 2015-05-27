//
//  CompassViewController.m
//  SupInTrack
//
//  Created by Alvin Meimoun on 26/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#import "CompassViewController.h"

@interface CompassViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *compassView;
@property (weak, nonatomic) IBOutlet UILabel *campusNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation CompassViewController

CampusModel* nearestCampus;
CLLocationManager* locationManagerCompass;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LoadViewController* parentLoadController = (LoadViewController*)self.navigationController.viewControllers[0];
    if(parentLoadController != nil && parentLoadController.nearestCampus != nil){
        [self bindCampus:parentLoadController.nearestCampus];
    }
    
    if(CLLocationManager.headingAvailable){
        //cas où une boussole est disponible sur l'appareil
        locationManagerCompass = [[CLLocationManager alloc] init];
        locationManagerCompass.delegate = self;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
            [locationManagerCompass requestWhenInUseAuthorization];
        
        [locationManagerCompass startUpdatingHeading];
    } else {
        //cas où la boussole n'est pas disponible
        self.compassView.transform = CGAffineTransformMakeRotation(nearestCampus.angle.floatValue *M_PI/180);
    }
    
}

-(void) bindCampus:(CampusModel*)model {
    nearestCampus = model;
    [self.campusNameLabel setText:model.name];
    [self.distanceLabel setText:[NSString stringWithFormat:@"%.1f km", model.distance.doubleValue/1000]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if(nearestCampus != nil){
        float heading = newHeading.magneticHeading;
        float headingDegrees = (heading*M_PI/180);
        self.compassView.transform = CGAffineTransformMakeRotation(headingDegrees + nearestCampus.angle.floatValue *M_PI/180);
    }
}

@end
