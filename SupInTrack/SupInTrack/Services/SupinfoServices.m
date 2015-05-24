//
//  SupinfoServices.m
//  SupInTrack
//
//  Created by Alvin Meimoun on 22/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#import "SupinfoServices.h"

@implementation SupinfoServices

+(NSArray*) getCampusesFromSupinfoWebsite:(NSError*) error{
    //Récupération de la page web
    NSString* htmlString = [NSString stringWithContentsOfURL: [NSURL URLWithString:@"http://www.supinfo.com/campus"] encoding:NSUTF8StringEncoding error:&error];
    
    if(error != nil) return nil;
    NSMutableArray* returnArray = [[NSMutableArray alloc] init];
    
    //Application regex
    NSRegularExpression* regexCampusList = [NSRegularExpression regularExpressionWithPattern:REGEX_CAMPUS_LIST options:0 error:&error];
    NSArray* matches = [regexCampusList matchesInString:htmlString options:0 range:NSMakeRange(0, [htmlString length])];
    for ( NSTextCheckingResult* match in matches )
    {
        CampusModel* model = [[CampusModel alloc] init];
        
        NSMutableString* campusListItemHtml = [NSMutableString stringWithString:[[[htmlString substringWithRange:[match range]] stringByAppendingString:@"</P>"] stringByReplacingOccurrencesOfString:@"<BR>" withString:@""]];
        //Supression du tag img qui n'étais pas fermé
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<img[^>]*>" options:NSRegularExpressionCaseInsensitive error:nil];
        [regex replaceMatchesInString:campusListItemHtml
                              options:0
                                range:NSMakeRange(0, campusListItemHtml.length)
                         withTemplate:@""];
        
        //Parsing de l'url de la fiche campus
        GDataXMLElement* campusListItemParser = [[GDataXMLElement alloc] initWithXMLString:campusListItemHtml error:nil];
        GDataXMLNode* campusListItemALinkTag = [campusListItemParser childAtIndex:0];
        
        NSString* campusName = campusListItemALinkTag.stringValue;
        if(campusName == nil || campusName.length == 0){
            campusListItemALinkTag = [campusListItemParser childAtIndex:1];
            campusName = campusListItemALinkTag.stringValue;
        }
        
        NSRegularExpression* regexHref = [NSRegularExpression regularExpressionWithPattern:REGEX_EXTRACT_HREF options:0 error:&error];
        NSArray* matchesHrefInCampusList = [regexHref matchesInString:campusListItemALinkTag.XMLString options:0 range:NSMakeRange(0, campusListItemALinkTag.XMLString.length)];
        if(matchesHrefInCampusList.count == 0){
            break;
        }

        NSString* campusLink = [campusListItemALinkTag.XMLString substringWithRange:(NSRange)[[matchesHrefInCampusList firstObject] range]];
        campusLink = [[campusLink substringToIndex:campusLink.length-1] substringFromIndex:9];
        
        model.name = campusName;
        model.pageUrl = campusLink;
        
        
        //Obtention des details depuis la page du campus
        NSString* htmlDetailsString = [NSString stringWithContentsOfURL: [NSURL URLWithString:@"http://www.supinfo.com/campus"] encoding:NSUTF8StringEncoding error:&error];
        if(error != nil) return nil;
        
        GDataXMLDocument* detailsDocument = [[GDataXMLDocument alloc] initWithXMLString:htmlDetailsString options:0 error:&error];
        
        
    }
    
    return returnArray;
}

@end