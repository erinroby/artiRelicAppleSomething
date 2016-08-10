//
//  ShowToPublish.m
//  artiRelicAppleSomething
//
//  Created by Jeremy Moore on 8/9/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "ShowToPublish.h"

@interface ShowToPublish()  <PFSubclassing>


@end


@implementation ShowToPublish

@dynamic title;
@dynamic subtitle;
@dynamic desc;
@dynamic thumbnail;
@dynamic image;
@dynamic curator;
@dynamic pieces;

+ (void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"ShowToPublish";
}

+(instancetype)publishShowWithTitle:(NSString *)title subtitle:(NSString *)subtitle desc:(NSString *)desc {
    ShowToPublish *show = [ShowToPublish new];
    show.title = title;
    show.subtitle = subtitle;
    show.desc = desc;
    return show;
    
}

@end
