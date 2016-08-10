//
//  Show.h
//  artiRelicAppleSomething
//
//  Created by David Swaintek on 8/10/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Parse/Parse.h>

#import "Curator.h"
//#import "Piece.h"
#import "Beacon.h"


@interface Show : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSData *image;
@property (strong, nonatomic) NSData *thumbnail;
@property (strong, nonatomic) Curator *curator;

@property (strong, nonatomic) NSMutableArray *pieces;

+(instancetype)publishShowWithTitle:(NSString *)title subtitle:(NSString *)subtitle desc:(NSString *)desc;

@end
