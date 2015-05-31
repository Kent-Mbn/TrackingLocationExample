//
//  Common.h
//  ParentalControlChildren
//
//  Created by CHAU HUYNH on 5/8/15.
//  Copyright (c) 2015 CHAU HUYNH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Define.h"

@interface Common : NSObject

+(void) showAlertView:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle arrayTitleOtherButtons:(NSArray *)arrayTitleOtherButtons tag:(int)tag;
+ (CLLocationCoordinate2D) get2DCoordFromString:(NSString*)coordString;
+ (void) updateTimeWhenTerminateApp:(NSString *) time;
+ (NSString *) getTimeWhenTerminateApp;
+ (void) showNetworkActivityIndicator;
+ (void) hideNetworkActivityIndicator;
+ (NSString *) pathOfFileLocalTrackingLocation;
+ (void) writeArrayToFileLocalTrackingLocation:(NSMutableArray *) arrToWrite;
+ (NSMutableArray *) readFileLocalTrackingLocation;
+ (void) writeObjToFileTrackingLocation:(NSDictionary *) dicObj;
+ (void) removeFileLocalTrackingLocation;
+ (float) calDistanceTwoCoordinate:(CLLocationCoordinate2D)firstPoint andSecondPoint:(CLLocationCoordinate2D)secondPoint;
+ (BOOL) isValidString:(NSString *) strCheck;
+ (BOOL) isValidCoordinate:(CLLocationCoordinate2D) checkPoint;


@end
