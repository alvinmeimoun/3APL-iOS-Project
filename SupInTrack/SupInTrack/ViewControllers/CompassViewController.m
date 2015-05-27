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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    LoadViewController* parentLoadController = (LoadViewController*)self.navigationController.viewControllers[0];
    if(parentLoadController != nil && parentLoadController.nearestCampus != nil){
        [self bindCampus:parentLoadController.nearestCampus];
    }
    
}

-(void) bindCampus:(CampusModel*)model {
    [self.campusNameLabel setText:model.name];
    [self.distanceLabel setText:[NSString stringWithFormat:@"%.1f km", model.distance.doubleValue/1000]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
