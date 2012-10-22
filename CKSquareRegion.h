//
//  CKSquareRegion.h
//
//  Created by Chris Knadler on 7/12/12.
//  Copyright (c) 2012 Chris Knadler.
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CKSquareRegion : NSObject

// Center coordinate of the square region
@property (nonatomic, readonly) CLLocationCoordinate2D center;

// String identifier or name for the region
@property (nonatomic, readonly) NSString *identifier;

// Side length is the length of a side of the square. This is assumed to be in meters.
- (id)initRegionWithCenter:(CLLocationCoordinate2D)center sideLength:(CLLocationDistance)sideLength identifier:(NSString *)identifier;

// A hit test for the coordinate region
- (BOOL)containsCoordinate:(CLLocationCoordinate2D)coordinate;

// Latitude and Longitude bounds
@property (nonatomic, readonly) double maxLat;
@property (nonatomic, readonly) double minLat;
@property (nonatomic, readonly) double maxLng;
@property (nonatomic, readonly) double minLng;

@end
