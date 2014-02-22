//
//  PKViewController.m
//  Münster-Runnermap
//
//  Created by Philipp Kirchner on 22.02.14.
//  Copyright (c) 2014 Philipp Kirchner. All rights reserved.
//

#import "PKViewController.h"


@interface UIViewController ()

@end

@implementation PKViewController

- (MKOverlayRenderer*) mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    if([overlay isKindOfClass:[MKPolyline class]]){
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        renderer.lineWidth = 1.0;
        renderer.strokeColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.25];
        return renderer;
    }
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://codeformuenster.github.io/muenster-runnermap/runkeeper_routeFetcher/routes/route.json"]];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *routeData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(routeData==nil){
        NSLog(@"%@", error);
        return;
    }
    NSDictionary *routeDict = [NSJSONSerialization JSONObjectWithData:routeData options:NSJSONWritingPrettyPrinted error:&error];
    //NSLog(@"%@", routeDict);
    NSArray *points = [routeDict objectForKey:@"features"];
    NSMutableArray *mapPoints = [NSMutableArray array];
    for(NSDictionary *point in points){
        NSDictionary *geometry = [point objectForKey:@"geometry"];
        NSArray *coordinates = [geometry objectForKey:@"coordinates"];
        NSUInteger size = [coordinates count];
        CLLocationCoordinate2D pointData[size];
        NSUInteger i=0;
        for(NSArray *coordinatePoint in coordinates){
            //NSLog(@"Coordinate: %@", coordinatePoint);
            MKMapPoint mapPoint = MKMapPointMake([(NSNumber*)coordinatePoint[0] doubleValue], [(NSNumber*)coordinatePoint[1] doubleValue]);
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(mapPoint.y, mapPoint.x);
            pointData[i]=coord;
            i++;
        }
        MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:pointData count:size];
        [self.mapView addOverlay:polyLine];

    
    }
    //51.962944°, 7.628694°
    CLLocationCoordinate2D muenster =CLLocationCoordinate2DMake(51.962944, 7.628694);
    MKCoordinateRegion center = MKCoordinateRegionMakeWithDistance(muenster, 15000, 15000);
    self.mapView.region = center;
    //NSLog(@"%@", mapPoints);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
