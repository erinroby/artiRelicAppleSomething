//
//  Piece.m
//  PatronArtiRelic
//
//  Created by Jeremy Moore on 8/11/16.
//  Copyright © 2016 erin.a.roby@gmail.com. All rights reserved.
//

#import "Piece.h"


@implementation Piece

@dynamic title;
@dynamic subtitle;
@dynamic desc;
@dynamic artist;
@dynamic price;
@dynamic image;
@dynamic thumbnail;
@dynamic audio;
@dynamic beaconID;

+ (void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"Piece";
}

@end
