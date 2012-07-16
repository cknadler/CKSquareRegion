//
//  CKSquareRegion.h
//
//  Created by Chris Knadler on 7/12/12.
//  Copyright (c) 2012 Chris Knadler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CKSquareRegion : NSObject

// Center coordinate of the square region
@property (nonatomic, readonly) CLLocationCoordinate2D center;

// String identifier or name for the region
@property (nonatomic, readonly) NSString *identifier;

// Side length is the length of any side of the square. This is assumed to be in meters.
- (id)initRegionWithCenter:(CLLocationCoordinate2D)center sideLength:(double)sideLength identifier:(NSString *)identifier;

// A hit test for the coordinate region
- (BOOL)containsCoordinate:(CLLocationCoordinate2D)coordinate;

// Latitude and Longitude bounds
@property (nonatomic, readonly) double maxLat;
@property (nonatomic, readonly) double minLat;
@property (nonatomic, readonly) double maxLng;
@property (nonatomic, readonly) double minLng;

@end
