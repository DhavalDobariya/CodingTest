//
//  LocationManager.m
//  CodingTest
//
//  Created by 891475 on 13/10/15.
//  Copyright (c) 2015 GE. All rights reserved.
//

#import "LocationManager.h"
#import "Constant.h"

@interface LocationManager ()
{

}

@property (nonatomic, strong) CLLocationManager *clLocationManager;

@end

@implementation LocationManager

@synthesize currentLocation;
@synthesize delegate;

- (instancetype)init
{
    if (self = [super init])
    {
        // Initate CLLocationManager
        self.clLocationManager = [[CLLocationManager alloc] init];
        self.clLocationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    }
    
    return self;
}

// Get Current Location
- (void)getCurrentLocation
{
    if (IS_OS8_OR_LATER)
    {
        NSUInteger code = [CLLocationManager authorizationStatus];
        
        if (code == kCLAuthorizationStatusNotDetermined){ // Check if we need to request user to give access of location services
            
            if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"])
            {
                if ([self.clLocationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
                    [self.clLocationManager requestAlwaysAuthorization];
            }
            
            else if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"])
            {
                if ([self.clLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
                    [self.clLocationManager requestWhenInUseAuthorization];
            }
            
            else
            {
                NSLog(@"info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    
    self.clLocationManager.delegate = self;
    [self.clLocationManager startUpdatingLocation];
}

#pragma mark-
#pragma mark CLLocationManager Delegate Methods

// Invokes when CLLocationManager updates location
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (newLocation != nil)
    {
        currentLocation = newLocation;
        [self.clLocationManager stopUpdatingLocation];
        
        self.clLocationManager.delegate = nil;
        
        if ([self.delegate respondsToSelector:@selector(locationManager:didUpdateCurrentLocation:withError:)])
            [self.delegate locationManager:self didUpdateCurrentLocation:currentLocation withError:nil];
    }
}

// Invokes when CLLocationManager faces error while retriving location
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSUInteger code = [CLLocationManager authorizationStatus];
    
    if (code == kCLAuthorizationStatusDenied) // Check if user has denied to give location service access to application.
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:REQUEST_CURRENT_LOCATION_ACCESS delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:ERROR_CURRENT_LOCATION delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    
    if ([self.delegate respondsToSelector:@selector(locationManager:didUpdateCurrentLocation:withError:)])
        [self.delegate locationManager:self didUpdateCurrentLocation:nil withError:error];
}

//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    if (locations != nil && [locations count]>0)
//    {
//        currentLocation = (CLLocation*)[locations lastObject]; // Use last object as current location
//        [self.clLocationManager stopUpdatingLocation];
//        
//        self.clLocationManager.delegate = nil;
//        
//        if ([self.delegate respondsToSelector:@selector(locationManager:didUpdateCurrentLocation:withError:)])
//            [self.delegate locationManager:self didUpdateCurrentLocation:currentLocation withError:nil];
//    }
//}

@end
