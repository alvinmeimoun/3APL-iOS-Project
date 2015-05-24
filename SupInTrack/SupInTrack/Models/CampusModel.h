//
//  CampusModel.h
//  SupInTrack
//
//  Created by Alvin Meimoun on 24/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#ifndef SupInTrack_CampusModel_h
#define SupInTrack_CampusModel_h

#import <Foundation/Foundation.h>

@interface CampusModel : NSObject

@property(nonatomic, weak) NSString* name;
@property(nonatomic, weak) NSString* pageUrl;
@property(nonatomic, weak) NSString* address;
@property(nonatomic, weak) NSNumber* latitude;
@property(nonatomic, weak) NSNumber* longitude;

@end

#endif
