//
//  ShowToPublish.h
//  artiRelicAppleSomething
//
//  Created by Jeremy Moore on 8/9/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <Parse/Parse.h>
#import "Curator.h"
#import "Show.h"
#import "Piece.h"
#import "Beacon.h"

@interface ShowToPublish : PFObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSData *thumbnail;
@property (strong, nonatomic) NSData *image;
@property (strong, nonatomic) Curator *curator;
@property (strong, nonatomic) NSArray<Piece *> *pieces;

+(instancetype)publishShowWithTitle:(NSString *)title subtitle:(NSString *)subtitle desc:(NSString *)desc;


@end
