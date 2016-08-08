//
//  Piece.m
//  artiRelicAppleSomething
//
//  Created by Jeremy Moore on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "Piece.h"
#import "Beacon.h"
#import "Show.h"

@implementation Piece

+ (instancetype)pieceWithTitle: (NSString *)title subtitle:(NSString *)subtitle desc:(NSString *)desc artist:(NSString *)artist medium:(NSString *)medium price:(NSString *)price dimensions:(NSString *)dimensions
{
    Piece *piece = [NSEntityDescription insertNewObjectForEntityForName:@"Piece" inManagedObjectContext:[NSManagedObjectContext managerContext]];
    
    piece.title = title;
    //piece.subtitle = subtitle;
    piece.desc = desc;
    piece.artist = artist;
    // piece.medium = medium;
    piece.price = price;
    // piece.dimensions = dimensions;
    
    return piece;
}

@end
