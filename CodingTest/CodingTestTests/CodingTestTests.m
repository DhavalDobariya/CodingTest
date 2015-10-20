//
//  CodingTestTests.m
//  CodingTestTests
//
//  Created by 891475 on 13/10/15.
//  Copyright (c) 2015 GE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "WSWrapper.h"

@interface CodingTestTests : XCTestCase

@end

@implementation CodingTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDictionaryToWeatherMapping {
    
    // Prepare sample data dictionary
    NSMutableDictionary *dicWeather = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *dicCurrently = [[NSMutableDictionary alloc] init];
    [dicCurrently setObject:[NSNumber numberWithFloat:80.15] forKey:@"temperature"];
    [dicCurrently setObject:[NSNumber numberWithFloat:5.3] forKey:@"windSpeed"];
    [dicCurrently setObject:@"Clear" forKey:@"summary"];
    [dicCurrently setObject:@"Clear_icon" forKey:@"icon"];
    
    [dicWeather setObject:dicCurrently forKey:@"currently"];
    
    // Map dictionary to Weather object
    Weather *weather = [WSWrapper weatherFromDictionary:dicWeather];
    
    // Check data mapping
    XCTAssert([weather.summary isEqualToString:[dicCurrently valueForKey:@"summary"]], @"Pass");
    XCTAssert([weather.iconName isEqualToString:[dicCurrently valueForKey:@"icon"]], @"Pass");
    XCTAssert([weather.temperature isEqual:[dicCurrently valueForKey:@"temperature"]], @"Pass");
    XCTAssert([weather.windSpeed isEqual:[dicCurrently valueForKey:@"windSpeed"]], @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
