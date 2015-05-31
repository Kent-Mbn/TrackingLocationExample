//
//  ViewController.m
//  TrackingLocationExample
//
//  Created by Huynh Phong Chau on 5/31/15.
//  Copyright (c) 2015 Huynh Phong Chau. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark FUNCTIONS
- (void) showActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:APP_NAME delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Show data", @"Delete data", nil];
    [actionSheet showInView:self.view];
}

-(void) loadAllLocationsToMap {
    //Load all location and show to map
    [_mapView removeAnnotations:_mapView.annotations];
    NSMutableArray *arrDataLocation = [Common readFileLocalTrackingLocation];
    NSLog(@"Tracking location: %@", arrDataLocation);
    if ([arrDataLocation count] > 0) {
        for (int i = 0; i < [arrDataLocation count]; i++) {
            NSDictionary *objDic = [arrDataLocation objectAtIndex:i];
            CLLocationCoordinate2D pointLocation = [Common get2DCoordFromString:[NSString stringWithFormat:@"%@,%@", objDic[@"lat"], objDic[@"long"]]];
            [self addPinViewToMap:pointLocation];
        }
        [self zoomToFitMapAnnotations:arrDataLocation];
    }
}

-(void) addPinViewToMap:(CLLocationCoordinate2D) location {
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    [_mapView addAnnotation:point];
}

-(void) zoomToFitMapAnnotations:(NSMutableArray *) arrPoints {
    if ([arrPoints count] > 0) {
        MKMapPoint points[[arrPoints count]];
        for (int i = 0; i < [arrPoints count]; i++) {
            NSDictionary *objDic = [arrPoints objectAtIndex:i];
            CLLocationCoordinate2D pointLocation = [Common get2DCoordFromString:[NSString stringWithFormat:@"%@,%@", objDic[@"lat"], objDic[@"long"]]];
            CLLocation *locationTemp = [[CLLocation alloc] initWithLatitude:pointLocation.latitude longitude:pointLocation.longitude];
            points[i] = MKMapPointForCoordinate(locationTemp.coordinate);
        }
        MKPolygon *poly = [MKPolygon polygonWithPoints:points count:[arrPoints count]];
        [_mapView setVisibleMapRect:[poly boundingMapRect] edgePadding:UIEdgeInsetsMake(100, 100, 100, 100) animated:YES];
    }
}

#pragma mark UIACTIONSHEET DELEGATE
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self loadAllLocationsToMap];
    }
    if (buttonIndex == 1) {
        [Common removeFileLocalTrackingLocation];
    }
}

#pragma mark - MAP DELEGATE
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString* AnnotationIdentifier = @"Annotation";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    if (!pinView) {
        MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        customPinView.pinColor = MKPinAnnotationColorRed;
        customPinView.animatesDrop = NO;
        customPinView.canShowCallout = YES;
        return customPinView;
        
    }
    return pinView;
}

#pragma mark ACTIONS
- (IBAction)actionMore:(id)sender {
    [self showActionSheet];
}
@end
