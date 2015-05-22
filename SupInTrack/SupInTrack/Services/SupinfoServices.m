//
//  SupinfoServices.m
//  SupInTrack
//
//  Created by Alvin Meimoun on 22/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#import "SupinfoServices.h"

@implementation SupinfoServices

+(void) getCampusesFromSupinfoWebsite:(NSError*) error{
    //Récupération de la page web
    NSString* htmlString = [NSString stringWithContentsOfURL: [NSURL URLWithString:@"http://www.supinfo.com/campus"] encoding:NSUTF8StringEncoding error:&error];
    
    //Applicaiton regex
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:REGEX_CAMPUS_LIST options:0 error:&error];
    NSArray* matches = [regex matchesInString:htmlString options:0 range:NSMakeRange(0, [htmlString length])];
    for ( NSTextCheckingResult* match in matches )
    {
        NSString* matchText = [[htmlString substringWithRange:[match range]] stringByAppendingString:@"</P>"];
        NSLog(@"match: %@", matchText);
    }
}

@end