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

+ (instancetype)pieceWithTitle:(NSString *)title desc:(NSString *)desc artist:(NSString *)artist price:(NSString *)price narration:(NSURL *)narration
{
    Piece *piece = [NSEntityDescription insertNewObjectForEntityForName:@"Piece" inManagedObjectContext:[NSManagedObjectContext managerContext]];
    
    piece.title = title;
    piece.desc = desc;
    piece.artist = artist;
    piece.price = price;
    piece.narration = narration;
    
    return piece;
}

@end
