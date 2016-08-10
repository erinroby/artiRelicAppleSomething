//
//  Piece.h
//  artiRelicAppleSomething
//
//  Created by David Swaintek on 8/10/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <Parse/Parse.h>

#import "Show.h"
#import "Beacon.h"

@interface Piece : PFObject <PFSubclassing>


@property (strong, nonatomic)Show *show;
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *subtitle;
@property (strong, nonatomic)NSString *desc;
@property (strong, nonatomic)NSString *artist;
@property (strong, nonatomic)NSString *price;
@property (strong, nonatomic)NSData *image;
@property (strong, nonatomic)NSData *thumbnail;
@property (strong, nonatomic)NSData *audio;
@property (strong, nonatomic)Beacon *beacon;

+(instancetype)pieceWithTitle:(NSString *)title desc:(NSString *)desc artist:(NSString *)artist price:(NSString *)price;


@end
