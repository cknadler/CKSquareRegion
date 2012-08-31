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

@interface CKSquareRegion ()

- (double)degreesToRadians:(double)degrees;
- (double)radiansToDegrees:(double)radians;

@end


@implementation CKSquareRegion
@synthesize center = _center;
@synthesize identifier = _identifier;
@synthesize maxLat = _maxLat;
@synthesize minLat = _minLat;
@synthesize maxLng = _maxLng;
@synthesize minLng = _minLng;

- (id)initRegionWithCenter:(CLLocationCoordinate2D)center sideLength:(CLLocationDistance)sideLength identifier:(NSString *)identifier
{
    self = [super init];
    if (self){
        // Basic assignment
        _center = center;
        _identifier = identifier;
        
        // Store the angular distance of each side from the center
        double angDist = sideLength / kEARTH_RADIUS_KM / 2;
        
        // Convert center lat and lng to radians
        double centerLatRad = [self degreesToRadians:center.latitude];
        double centerLngRad = [self degreesToRadians:center.longitude];
        
        // Calculate latitude range
        double maxLatRad = asin(sin(centerLatRad) * cos(angDist) +
                                cos(centerLatRad) * sin(angDist) * cos(kBEARING_NORTH));
        
        double minLatRad = asin(sin(centerLatRad) * cos(angDist) +
                                cos(centerLatRad) * sin(angDist) * cos(kBEARING_SOUTH));
        
        // Calculate longitude range
        // Longitude range requires coresponding latitudes:
        double tempLatRad;
        
        // Calculate max longitude
        tempLatRad = asin(sin(centerLatRad) * cos(angDist) +
                          cos(centerLatRad) * sin(angDist) * cos(kBEARING_EAST));
        
        double maxLngRad = centerLngRad + atan2(sin(kBEARING_EAST) * sin(angDist) * cos(centerLatRad),
                                                cos(angDist) - sin(centerLatRad) * sin(tempLatRad));
        
        // Calculate min longitude
        tempLatRad = asin(sin(centerLatRad) * cos(angDist) +
                          cos(centerLatRad) * sin(angDist) * cos(kBEARING_WEST));
        
        double minLngRad = centerLngRad + atan2(sin(kBEARING_WEST) * sin(angDist) * cos(centerLatRad),
                                                cos(angDist) - sin(centerLatRad) * sin(tempLatRad));
        
        // Convert lat and lng ranges to radians
        _maxLat = [self radiansToDegrees:maxLatRad];
        _minLat = [self radiansToDegrees:minLatRad];
        _maxLng = [self radiansToDegrees:maxLngRad];
        _minLng = [self radiansToDegrees:minLngRad];
    }
    return self;
}

// Hit testing
- (BOOL)containsCoordinate:(CLLocationCoordinate2D)coordinate
{
    BOOL inLatRange;
    BOOL inLngRange;
    
    if ((coordinate.latitude <= self.maxLat) && (coordinate.latitude >= self.minLat))
        inLatRange = YES;
    
    if ((coordinate.longitude <= self.maxLng) && (coordinate.longitude >= self.minLng))
        inLngRange = YES;
    
    return inLatRange && inLngRange;
}

#pragma mark - private

- (double)degreesToRadians:(double)degrees { return degrees * M_PI / 180; }

- (double)radiansToDegrees:(double)radians { return radians * 180 / M_PI; }

@end
