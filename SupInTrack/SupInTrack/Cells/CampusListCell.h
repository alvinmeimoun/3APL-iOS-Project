//
//  CampusListCell.h
//  SupInTrack
//
//  Created by Alvin Meimoun on 27/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#ifndef SupInTrack_CampusListCell_h
#define SupInTrack_CampusListCell_h

#import <UIKit/UIKit.h>
#import "../Models/CampusModel.h"

@interface CampusListCell : UITableViewCell

@property(nonatomic, weak) NSString* name;
@property(nonatomic, weak) NSString* distance;

-(void) bind:(CampusModel*)model;

@end

#endif
