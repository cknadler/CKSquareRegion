//
//  CKSquareRegion.m
//
//  Created by Chris Knadler on 7/12/12.
//  Copyright (c) 2012 Chris Knadler. All rights reserved.
//

#import "CKSquareRegion.h"

#define kBEARING_NORTH 0.0
#define kBEARING_EAST  .5 * M_PI
#define kBEARING_SOUTH M_PI
#define kBEARING_WEST  1.5 * M_PI

#define kEARTH_RADIUS_KM 6371.0

@implementation CKSquareRegion
@synthesize center = _center;
@synthesize identifier = _identifier;
@synthesize maxLat = _maxLat;
@synthesize minLat = _minLat;
@synthesize maxLng = _maxLng;
@synthesize minLng = _minLng;

- (id)initRegionWithCenter:(CLLocationCoordinate2D)center sideLength:(double)sideLength identifier:(NSString *)identifier
{
    self = [super init];
    if (self){
        // Basic assignment
        _center = center;
        _identifier = identifier;
        
        // Calculate latitude and longitude bounds
        _maxLat = asin(sin(self.center.latitude) * cos(sideLength/kEARTH_RADIUS_KM) + 
                       cos(self.center.latitude) * sin(sideLength/kEARTH_RADIUS_KM) * cos(kBEARING_NORTH));
        
        _minLat = asin(sin(self.center.latitude) * cos(sideLength/kEARTH_RADIUS_KM) + 
                       cos(self.center.latitude) * sin(sideLength/kEARTH_RADIUS_KM) * cos(kBEARING_SOUTH)); 
        
        _maxLng = self.center.longitude + atan2(sin(kBEARING_EAST) * sin(sideLength/kEARTH_RADIUS_KM) * cos(self.center.latitude), 
                                                cos(sideLength/kEARTH_RADIUS_KM) - sin(self.center.latitude) * sin(self.center.latitude));
        
        _minLng = self.center.longitude + atan2(sin(kBEARING_WEST) * sin(sideLength/kEARTH_RADIUS_KM) * cos(self.center.latitude), 
                                                cos(sideLength/kEARTH_RADIUS_KM) - sin(self.center.latitude) * sin(self.center.latitude));
    }
    return self;
}

// Hit testing
- (BOOL)containsCoordinate:(CLLocationCoordinate2D)coordinate
{
    BOOL inLatRange;
    BOOL inLngRange;
    
    if ((coordinate.latitude <= _maxLat) && (coordinate.latitude >= _minLat))
        inLatRange = YES;
    
    if ((coordinate.longitude <= _maxLng) && (coordinate.longitude >= _minLng))
        inLngRange = YES;
    
    return inLatRange && inLngRange; 
}

@end
