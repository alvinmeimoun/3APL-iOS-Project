//
//  SupinfoServices.m
//  SupInTrack
//
//  Created by Alvin Meimoun on 22/05/2015.
//  Copyright (c) 2015 SUPINFO. All rights reserved.
//

#import "SupinfoServices.h"

@implementation SupinfoServices

+(void) getCampusesFromSupinfoWebsiteWithCompletionHandler:(void(^)(NSArray * result, NSError* error))handler{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
    NSError* error;
    //Récupération de la page web
    NSString* htmlString = [NSString stringWithContentsOfURL: [NSURL URLWithString:@"http://www.supinfo.com/campus"] encoding:NSUTF8StringEncoding error:&error];
    
    if(error != nil){
        if(handler != nil) dispatch_sync(dispatch_get_main_queue(), ^{
            handler(nil, error);
        });
        return;
    }
    NSMutableArray* returnArray = [[NSMutableArray alloc] init];
    
    //Application regex
    NSRegularExpression* regexCampusList = [NSRegularExpression regularExpressionWithPattern:REGEX_CAMPUS_LIST options:0 error:&error];
    NSArray* matches = [regexCampusList matchesInString:htmlString options:0 range:NSMakeRange(0, [htmlString length])];
    for ( NSTextCheckingResult* match in matches )
    {
        CampusModel* model = [[CampusModel alloc] init];
        
        NSMutableString* campusListItemHtml = [NSMutableString stringWithString:[[[htmlString substringWithRange:[match range]] stringByAppendingString:@"</P>"] stringByReplacingOccurrencesOfString:@"<BR>" withString:@""]];
        //Supression du tag img qui n'étais pas fermé
        NSRegularExpression *regexTagImg = [NSRegularExpression regularExpressionWithPattern:@"<img[^>]*>" options:NSRegularExpressionCaseInsensitive error:nil];
        [regexTagImg replaceMatchesInString:campusListItemHtml
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
        if(matchesHrefInCampusList.count != 0){
            NSString* campusLink = [campusListItemALinkTag.XMLString substringWithRange:(NSRange)[[matchesHrefInCampusList firstObject] range]];
            campusLink = [[campusLink substringToIndex:campusLink.length-1] substringFromIndex:9];
            
            model.name = campusName;
            model.pageUrl = campusLink;
            
            
            //Obtention des details depuis la page du campus
            NSString* htmlDetailsString = [NSString stringWithContentsOfURL: [NSURL URLWithString:campusLink] encoding:NSUTF8StringEncoding error:&error];
            if(error != nil){
                if(handler != nil) dispatch_sync(dispatch_get_main_queue(), ^{
                    handler(nil, error);
                });
                return;
            }
            
            NSRegularExpression* regexDetailsMain = [NSRegularExpression regularExpressionWithPattern:REGEX_CAMPUS_DETAILS_ADDRESS_START options:0 error:&error];
            NSArray* regexDetailsMainMatches = [regexDetailsMain matchesInString:htmlDetailsString options:0 range:NSMakeRange(0, htmlDetailsString.length)];
            if(regexDetailsMainMatches.count != 0){
                int offset = 0;
                NSString* regexDetalsMainString = [htmlDetailsString substringWithRange:(NSRange)[[regexDetailsMainMatches firstObject] range]];
                NSArray* searchAddressSplitted = [regexDetalsMainString componentsSeparatedByString:@"<br>"];
                NSArray* searchAddressSplitted1_b = [searchAddressSplitted[0] componentsSeparatedByString:@"<b>"];
                NSString* addressLine1 = [searchAddressSplitted1_b[1] stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
                
                if([addressLine1 isEqualToString:campusName]){
                    offset++;
                    if(searchAddressSplitted.count >= 2){
                        addressLine1 = [[[searchAddressSplitted[1] stringByReplacingOccurrencesOfString:@"</b>" withString:@""] stringByReplacingOccurrencesOfString:@"<br/>" withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                    } else {
                        addressLine1 = @"";
                    }
                    
                }
                NSString* addressLine2 = [campusName stringByReplacingOccurrencesOfString:@"SUPINFO " withString:@""];
                NSString* addressFinal = [NSString stringWithFormat:@"%@ %@", addressLine1, addressLine2];
                model.address = addressFinal;
                [returnArray addObject:model];
            }
            
        }
        
    }
        if(handler != nil) dispatch_sync(dispatch_get_main_queue(), ^{
            handler(returnArray, error);
        });
    });
    /*//Geocoding
    for(CampusModel* model in returnArray){
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:model.address completionHandler:^(NSArray* placemarks, NSError* error){
            geocodedModelsCount++;
            
            for (CLPlacemark* aPlacemark in placemarks)
            {
                if(error != nil){
                    NSLog(error.description);
                }
                
                //NSString *latDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.latitude];
                //NSString *lngDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.longitude];
                model.longitude = [NSNumber numberWithFloat:aPlacemark.location.coordinate.longitude];
                model.latitude = [NSNumber numberWithFloat:aPlacemark.location.coordinate.latitude];
                
                NSLog([NSString stringWithFormat:@"a %ld", returnArray.count]);
                NSLog([NSString stringWithFormat:@"b %d", geocodedModelsCount]);
                if(returnArray.count == geocodedModelsCount){
                    if(handler != nil) handler(returnArray, error);
                    NSLog(@"call handler");
                    return;
                }
                
            }
        }];

    }*/
}

@end