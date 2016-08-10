//
//  Beacon.m
//  artiRelicAppleSomething
//
//  Created by David Swaintek on 8/10/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "Beacon.h"

@implementation Beacon

@dynamic uiid;
@dynamic major;
@dynamic minor;

+ (void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"Beacon";
}

+(instancetype)beaconWithUIID:(NSString *)uiid major:(NSString *)major minor:(NSString *)minor
{
    Beacon *beacon = [[Beacon alloc]init];
    beacon.uiid = uiid;
    beacon.major = major;
    beacon.minor = minor;
    return beacon;
}

@end

