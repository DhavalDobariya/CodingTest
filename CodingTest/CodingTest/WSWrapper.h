//
//  WSWrapper.h
//  CodingTest
//
//  Created by 891475 on 13/10/15.
//  Copyright (c) 2015 GE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import "Weather.h"

@interface WSWrapper : NSObject
{
    
}

// Get Weather for Location
// URL : https://api.forecast.io/forecast/:API_KEY/:lat,:long
+ (void)getWeatherForLocation:(CLLocation*)location OnSuccess:(void (^)(Weather* weather))successBlock OnFailure:(void (^)(NSError *error))failureBlock;

#pragma mark-
#pragma mark Model Mapper methods

// Maps dictionary to Weather object
+ (Weather*)weatherFromDictionary:(NSDictionary*)dicWeather;

@end
