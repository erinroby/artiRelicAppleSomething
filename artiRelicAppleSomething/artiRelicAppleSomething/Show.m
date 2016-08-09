//
//  Show.m
//  artiRelicAppleSomething
//
//  Created by Jeremy Moore on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "Show.h"
#import "Curator.h"
#import "Piece.h"

@implementation Show

+ (instancetype)showWithTitle:(NSString *)title subtitle:(NSString *)subtitle desc:(NSString *)desc
{
    Show *show = [NSEntityDescription insertNewObjectForEntityForName:@"Show" inManagedObjectContext:[NSManagedObjectContext managerContext]];
    
    show.title = title;
    show.subtitle = subtitle;
    show.desc = desc;
    //show.gallery = gallery;
    //show.dates = dates;
    //show.curator = curator;
    
    return show;
}


@end
