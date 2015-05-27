//
//  ViewController.m
//  SupInTrack
//
//  Created by Alvin Meimoun on 22/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#import "LoadViewController.h"

#import "SupinfoServices.h"

@interface LoadViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblLoadingProgress;

@end

@implementation LoadViewController

@synthesize nearestCampus;
@synthesize campusList;

CLLocationManager* locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    [self doLoad];
}

-(void)doLoad{
    [self.lblLoadingProgress setText:@"Récupération de la liste des campus"];
    
    //Obtention de la liste des campus
    [SupinfoServices getCampusesFromSupinfoWebsiteWithCompletionHandler:^(NSArray * result, NSError* error){
        campusList = result;
        
        //Obtention de la position utilisateur
        [self.lblLoadingProgress setText:@"Obtention de la position"];
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
            [locationManager requestWhenInUseAuthorization];
        
        [locationManager startUpdatingLocation];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //Recherche du campus le plus proche
    [self.lblLoadingProgress setText:@"Recherche du campus le plus proche"];
    CLLocation* currentPosition = [locations lastObject];
    
    nearestCampus = [SupinfoServices getNearestCampusFromList:campusList withLatitude:currentPosition.coordinate.latitude andLongitude:currentPosition.coordinate.longitude];
    
    
    [self performSegueWithIdentifier:@"segue_show_compass" sender:self];
}

@end
