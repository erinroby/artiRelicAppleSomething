//
//  Piece.m
//  artiRelicAppleSomething
//
//  Created by David Swaintek on 8/10/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "Piece.h"

@implementation Piece

@dynamic show;
@dynamic title;
@dynamic subtitle;
@dynamic desc;
@dynamic artist;
@dynamic price;
@dynamic image;
@dynamic thumbnail;
@dynamic audio;
@dynamic beacon;

+ (void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"Piece";
}

+(instancetype)pieceWithTitle:(NSString *)title desc:(NSString *)desc artist:(NSString *)artist price:(NSString *)price
{
    Piece *piece = [[Piece alloc]init];
    piece.title = title;
    piece.desc = desc;
    piece.artist = artist;
    piece.price = price;
    
    return piece;
}

@end



















