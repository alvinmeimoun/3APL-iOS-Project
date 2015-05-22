//
//  SupinfoServices.h
//  SupInTrack
//
//  Created by Alvin Meimoun on 22/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#ifndef SupInTrack_SupinfoServices_h
#define SupInTrack_SupinfoServices_h

#import <Foundation/Foundation.h>

static NSString* REGEX_CAMPUS_LIST = @"<P id=\"campus-.+<BR>";

@interface SupinfoServices : NSObject

+(void) getCampusesFromSupinfoWebsite:(NSError*) error;

@end

#endif
