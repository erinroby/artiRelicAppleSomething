//
//  Show.m
//  PatronArtiRelic
//
//  Created by Jeremy Moore on 8/11/16.
//  Copyright © 2016 erin.a.roby@gmail.com. All rights reserved.
//

#import "Show.h"

@implementation Show

@dynamic title;
@dynamic subtitle;
@dynamic desc;
@dynamic thumbnail;
@dynamic image;
@dynamic pieces;

+(void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"Show";
}

@end
