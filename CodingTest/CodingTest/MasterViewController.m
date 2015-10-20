//
//  MasterViewController.m
//  CodingTest
//
//  Created by 891475 on 13/10/15.
//  Copyright (c) 2015 GE. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()<LocationManagerDelegate>
{
    LocationManager *locationManager;
}

@end

@implementation MasterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Weather Forecast";
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getCurrentLocation)
                                                 name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self getCurrentLocation];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

#pragma mark-
#pragma mark Custom Methods

// Get Current location of user's device
-(void)getCurrentLocation
{
    if (locationManager == nil)
        locationManager = [[LocationManager alloc] init];
    
    activity.hidden = FALSE;
    [activity startAnimating];
    
    locationManager.delegate = self;
    [locationManager getCurrentLocation];
}

// Set Weather icon for rainy, sunny and clear weather.
// For weather other than that, it will show default icon
- (void)setWeatheIconForWeather:(Weather*)weather
{
    if ([weather.iconName containsString:@"rain"])
        imgviewIcon.image = [UIImage imageNamed:@"rainy_icon.png"];
    
    else if ([weather.iconName containsString:@"sun"])
        imgviewIcon.image = [UIImage imageNamed:@"sunny_icon.png"];
    
    else if ([weather.iconName containsString:@"clear"])
        imgviewIcon.image = [UIImage imageNamed:@"clear_icon.png"];
    
    else
        imgviewIcon.image = [UIImage imageNamed:@"default_weather_icon.png"];
}

#pragma mark-
#pragma mark LocationManager Delegate methods

// Invokes when CLLocationManager updates location or receives error
- (void)locationManager:(LocationManager*)locationManager didUpdateCurrentLocation:(CLLocation*)location withError:(NSError*)error
{
    if (error == nil)
    {
        NSLog(@"Current location with Latitude=%lf Longitude=%lf",location.coordinate.latitude,location.coordinate.longitude);
        
        [WSWrapper getWeatherForLocation:location OnSuccess:^(Weather *weather) {
            
            [activity stopAnimating];
            activity.hidden = TRUE;
            
            lblTemp.text = [NSString stringWithFormat:@"Temperature : %.2f°F",[weather.temperature floatValue]];
            lblSummary.text = [NSString stringWithFormat:@"Summary : %@",weather.summary];
            lblWindSpeed.text = [NSString stringWithFormat:@"Wind Speed : %.2f MPH",[weather.windSpeed floatValue]];
            [self setWeatheIconForWeather:weather];
            
        } OnFailure:^(NSError *error) {
            
            [activity stopAnimating];
            activity.hidden = TRUE;
        }];
    }
    else
    {
        [activity stopAnimating];
        activity.hidden = TRUE;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
