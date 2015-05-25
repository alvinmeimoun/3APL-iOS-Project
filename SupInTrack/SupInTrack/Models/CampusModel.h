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

@property(atomic, strong) NSString* name;
@property(atomic, strong) NSString* pageUrl;
@property(atomic, strong) NSString* address;
@property(atomic, strong) NSNumber* latitude;
@property(atomic, strong) NSNumber* longitude;

@end

#endif
