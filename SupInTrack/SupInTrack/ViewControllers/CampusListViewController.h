//
//  CampusListViewController.h
//  SupInTrack
//
//  Created by Alvin Meimoun on 27/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#ifndef SupInTrack_CampusListViewController_h
#define SupInTrack_CampusListViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "../Models/CampusModel.h"
#import "../LoadViewController.h"
#import "../Cells/CampusListCell.h"

@interface CampusListViewController : UIViewController

-(void) bindCampuses:(NSArray*)campusModels;

@end

#endif
