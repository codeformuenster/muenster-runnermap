//
//  PKViewController.h
//  Münster-Runnermap
//
//  Created by Philipp Kirchner on 22.02.14.
//  Copyright (c) 2014 Philipp Kirchner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface PKViewController : UIViewController<MKMapViewDelegate>
@property (readwrite, assign) IBOutlet MKMapView *mapView;

@end
