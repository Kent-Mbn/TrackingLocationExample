//
//  Common.m
//  ParentalControlChildren
//
//  Created by CHAU HUYNH on 5/8/15.
//  Copyright (c) 2015 CHAU HUYNH. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (void) showAlertView:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle arrayTitleOtherButtons:(NSArray *)arrayTitleOtherButtons tag:(int)tag {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    alert.tag = tag;
    
    if([arrayTitleOtherButtons count] > 0) {
        for (int i = 0; i < [arrayTitleOtherButtons count]; i++) {
            [alert addButtonWithTitle:arrayTitleOtherButtons[i]];
        }
    }
    
    [alert show];
}

+ (CLLocationCoordinate2D) get2DCoordFromString:(NSString*)coordString
{
    CLLocationCoordinate2D location;
    NSArray *coordArray = [coordString componentsSeparatedByString: @","];
    location.latitude = ((NSNumber *)coordArray[0]).doubleValue;
    location.longitude = ((NSNumber *)coordArray[1]).doubleValue;
    
    return location;
}
+ (void) updateTimeWhenTerminateApp:(NSString *) time {
    [[NSUserDefaults standardUserDefaults] setObject:time forKey:@"timeTerminate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) getTimeWhenTerminateApp {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"timeTerminate"];
}
+ (void) showNetworkActivityIndicator
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

+ (void) hideNetworkActivityIndicator
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

+ (NSString *) pathOfFileLocalTrackingLocation {
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [filePaths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:NAME_LOCAL_FILE_SAVE_LOCATION];
    return path;
}

+ (void) writeArrayToFileLocalTrackingLocation:(NSMutableArray *) arrToWrite {
    [arrToWrite writeToFile:[self pathOfFileLocalTrackingLocation] atomically:YES];
}

+ (NSMutableArray *) readFileLocalTrackingLocation {
    NSMutableArray *arrReturn = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self pathOfFileLocalTrackingLocation]]) {
        arrReturn = [[NSMutableArray arrayWithContentsOfFile:[self pathOfFileLocalTrackingLocation]] mutableCopy];
    }
    return arrReturn;
}

+ (void) writeObjToFileTrackingLocation:(NSDictionary *) dicObj {
    //Get data
    NSMutableArray *arrInit = [self readFileLocalTrackingLocation];
    if (arrInit != nil) {
        [arrInit addObject:dicObj];
    } else {
        arrInit = [[NSMutableArray alloc] init];
        [arrInit addObject:dicObj];
    }
    
    //Write to file
    [self writeArrayToFileLocalTrackingLocation:arrInit];
}

+ (void) removeFileLocalTrackingLocation {
    NSString *filePath = [self pathOfFileLocalTrackingLocation];
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
}

+ (float) calDistanceTwoCoordinate:(CLLocationCoordinate2D)firstPoint andSecondPoint:(CLLocationCoordinate2D)secondPoint {
    CLLocation *userloc = [[CLLocation alloc]initWithLatitude:firstPoint.latitude longitude:firstPoint.longitude];
    CLLocation *dest = [[CLLocation alloc]initWithLatitude:secondPoint.latitude longitude:secondPoint.longitude];
    CLLocationDistance dist = [userloc distanceFromLocation:dest];
    return (float)dist;
}

+ (BOOL) isValidString:(NSString *) strCheck {
    if (strCheck.length > 0 && ![strCheck isEqual:[NSNull null]] && ![strCheck isEqualToString:@"(null)"]) {
        return YES;
    }
    return NO;
}

+ (BOOL) isValidCoordinate:(CLLocationCoordinate2D) checkPoint {
    if (checkPoint.latitude != 0 && checkPoint.longitude != 0 && CLLocationCoordinate2DIsValid(checkPoint)) {
        return YES;
    }
    return NO;
}
@end
