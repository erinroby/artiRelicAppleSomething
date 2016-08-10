//
//  Show.m
//  artiRelicAppleSomething
//
//  Created by David Swaintek on 8/10/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "Show.h"

@implementation Show

@synthesize title;
@synthesize subtitle;
@synthesize desc;
@synthesize thumbnail;
@synthesize image;
@synthesize curator;
@synthesize pieces;

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
