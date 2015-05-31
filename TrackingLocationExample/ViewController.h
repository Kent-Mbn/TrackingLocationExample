//
//  ViewController.h
//  TrackingLocationExample
//
//  Created by Huynh Phong Chau on 5/31/15.
//  Copyright (c) 2015 Huynh Phong Chau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Common.h"

@interface ViewController : UIViewController<MKMapViewDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)actionMore:(id)sender;

@end

