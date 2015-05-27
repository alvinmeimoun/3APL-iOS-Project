//
//  CampusListCell.m
//  SupInTrack
//
//  Created by Alvin Meimoun on 27/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#import "CampusListCell.h"

@interface CampusListCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;


@end

@implementation CampusListCell

-(void) bind:(CampusModel*)model{
    [self.nameLabel setText:model.name];
    [self.distanceLabel setText:[NSString stringWithFormat:@"%.1f km", model.distance.floatValue/1000]];
}

@end
