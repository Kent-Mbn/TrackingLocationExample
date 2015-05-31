//
//  AppDelegate.m
//  TrackingLocationExample
//
//  Created by Huynh Phong Chau on 5/31/15.
//  Copyright (c) 2015 Huynh Phong Chau. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)dealloc
{
    //Step 4: remove notification for get new location
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationGetNewLocation object:nil];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Step 5: Init and begin...
    self.shareModel = [LocationShareModel sharedModel];
    
    //We have to make sure that the Background App Refresh is enable for the Location updates to work in the background.
    if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied){
        [Common showAlertView:APP_NAME message:MSS_UIBackgroundRefreshStatusDenied delegate:self cancelButtonTitle:@"OK" arrayTitleOtherButtons:nil tag:0];
    }else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted){
        [Common showAlertView:APP_NAME message:MSS_UIBackgroundRefreshStatusRestricted delegate:self cancelButtonTitle:@"OK" arrayTitleOtherButtons:nil tag:0];
    } else{
        
        /* INIT for background mode */
        self.locationTracker = [[LocationTracker alloc]init];
        self.locationTracker.timeIntervalGetLocationTracking = timeForGetNewLocation;
        self.locationTracker.timeProcessTracking = timeForProcessTracking;
        self.locationTracker.timeDelayTracking = timeForDelayTracking;
        [self.locationTracker startLocationTracking];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(returnNewLocation:)
                                                     name:kNotificationGetNewLocation
                                                   object:nil];
        /* INIT for killed app */
        if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
            // are actually from the key "UIApplicationLaunchOptionsLocationKey"
            self.shareModel.afterResume = YES;
            self.shareModel.anotherLocationManager = [[CLLocationManager alloc]init];
            self.shareModel.anotherLocationManager.delegate = self;
            self.shareModel.anotherLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
            self.shareModel.anotherLocationManager.distanceFilter = kCLDistanceFilterNone;
            
            if(IS_OS_8_OR_LATER) {
                [self.shareModel.anotherLocationManager requestAlwaysAuthorization];
            }
            
            [self.shareModel.anotherLocationManager startMonitoringSignificantLocationChanges];
        }
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //Step 6:
    NSLog(@"applicationDidEnterBackground");
    [self.shareModel.anotherLocationManager stopMonitoringSignificantLocationChanges];
    
    if(IS_OS_8_OR_LATER) {
        [self.shareModel.anotherLocationManager requestAlwaysAuthorization];
    }
    [self.shareModel.anotherLocationManager startMonitoringSignificantLocationChanges];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //Step 7:
    self.shareModel.afterResume = NO;
    
    if(self.shareModel.anotherLocationManager)
        [self.shareModel.anotherLocationManager stopMonitoringSignificantLocationChanges];
    
    self.shareModel.anotherLocationManager = [[CLLocationManager alloc]init];
    self.shareModel.anotherLocationManager.delegate = self;
    self.shareModel.anotherLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.shareModel.anotherLocationManager.distanceFilter = kCLDistanceFilterNone;
    
    if(IS_OS_8_OR_LATER) {
        [self.shareModel.anotherLocationManager requestAlwaysAuthorization];
    }
    [self.shareModel.anotherLocationManager startMonitoringSignificantLocationChanges];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - LOCATION
//Step 8: this function, when tracking class get new location, it will push new location fo this function.

- (void) returnNewLocation :(NSNotification *) noti {
    NSDictionary *theData = [noti userInfo];
    if (theData != nil) {
        NSLog(@"+++ New location: %@", theData);
        lastLocationAppDelegate = [Common get2DCoordFromString:[NSString stringWithFormat:@"%@,%@", theData[@"lat"], theData[@"long"]]];
        NSDictionary *dicObj = [NSDictionary dictionaryWithObjects:@[@(lastLocationAppDelegate.latitude),@(lastLocationAppDelegate.longitude),[NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]]] forKeys:@[@"lat",@"long",@"created_at"]];
        [Common writeObjToFileTrackingLocation:dicObj];
    }
}

@end
