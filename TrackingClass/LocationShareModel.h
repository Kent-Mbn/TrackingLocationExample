//
//  LocationShareModel.h
//  Location
//
//  Created by Rick
//  Copyright (c) 2014 Location. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BackgroundTaskManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationShareModel : NSObject

/* Property for tracking location in background mode */
@property (nonatomic) NSTimer *timerIntervalGetLocationTracking;
@property (nonatomic) NSTimer *timerIntervalUpdateLocationTracking;
@property (nonatomic) NSTimer *timerDelayTracking;
@property (nonatomic) NSTimer *timerProcessTracking;

@property (nonatomic) BackgroundTaskManager * bgTask;
@property (nonatomic) NSMutableArray *myLocationArray;

/* Property for tracking location in killed app mode */
@property (nonatomic) CLLocationManager * anotherLocationManager;
@property (nonatomic) BOOL afterResume;

+(id)sharedModel;

@end
