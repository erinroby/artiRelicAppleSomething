//
//  Show.m
//  artiRelicAppleSomething
//
//  Created by David Swaintek on 8/10/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "Show.h"

@implementation Show

@dynamic title;
@dynamic subtitle;
@dynamic desc;
@dynamic thumbnail;
@dynamic image;
@dynamic curator;
@dynamic pieces;

+(void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"Show";
}

+(instancetype)publishShowWithTitle:(NSString *)title subtitle:(NSString *)subtitle desc:(NSString *)desc
{
    Show *show = [[Show alloc]init];
    show.title = title;
    show.subtitle = subtitle;
    show.desc = desc;
    
    return show;
}

@end
