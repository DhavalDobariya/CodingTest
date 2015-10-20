//
//  Weather.h
//  CodingTest
//
//  Created by 891475 on 13/10/15.
//  Copyright (c) 2015 GE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (strong, nonatomic) NSNumber* temperature; //Current Temperature (in Feherenhit)
@property (strong, nonatomic) NSNumber* windSpeed; // Wind Speed (in MPH)
@property (strong, nonatomic) NSString* summary;
@property (strong, nonatomic) NSString* iconName; // Weather Icon

@end
