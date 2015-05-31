//
//  Define.h
//  TrackingLocationExample
//
//  Created by Huynh Phong Chau on 5/31/15.
//  Copyright (c) 2015 Huynh Phong Chau. All rights reserved.
//

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define kNotificationGetNewLocation @"kNotificationGetNewLocation"
#define APP_NAME @"Tracking Location"

#define timeForGetNewLocation 10
#define timeForProcessTracking 60
#define timeForDelayTracking 10

#define APP_DELEGATE (AppDelegate *)[UIApplication sharedApplication].delegate
#define NAME_LOCAL_FILE_SAVE_LOCATION @"localTrackingLocation.plist"

#pragma mark - TRACKING LOCATION
#define MSS_UIBackgroundRefreshStatusDenied @"The app doesn't work without the Background App Refresh enabled. To turn it on, go to Settings > General > Background App Refresh"
#define MSS_UIBackgroundRefreshStatusRestricted @"The functions of this app are limited because the Background App Refresh is disable."
