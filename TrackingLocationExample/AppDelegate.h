//
//  AppDelegate.h
//  TrackingLocationExample
//
//  Created by Huynh Phong Chau on 5/31/15.
//  Copyright (c) 2015 Huynh Phong Chau. All rights reserved.
//

#import <UIKit/UIKit.h>

//Step 1: Import needed class
#import "LocationTracker.h"
#import "Define.h"
#import "Common.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    //Step 2: Declare variable which contain new location tracking
    CLLocationCoordinate2D lastLocationAppDelegate;
}

@property (strong, nonatomic) UIWindow *window;

//Step 3: Declare variable for LocationTracker class
@property LocationTracker * locationTracker;
@property (strong,nonatomic) LocationShareModel * shareModel;


@end

