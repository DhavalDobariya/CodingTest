//
//  MasterViewController.h
//  CodingTest
//
//  Created by 891475 on 13/10/15.
//  Copyright (c) 2015 GE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationManager.h"
#import "WSWrapper.h"

@interface MasterViewController : UIViewController
{
    IBOutlet UIImageView *imgviewIcon;
    IBOutlet UILabel *lblTemp;
    IBOutlet UILabel *lblWindSpeed;
    IBOutlet UILabel *lblSummary;
    
    IBOutlet UIActivityIndicatorView *activity;
}

// Set Weather icon based on weather
- (void)setWeatheIconForWeather:(Weather*)weather;

// Get Current location of user's device
- (void)getCurrentLocation;

@end
