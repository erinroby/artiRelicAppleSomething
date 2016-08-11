//
//  Piece.h
//  PatronArtiRelic
//
//  Created by Jeremy Moore on 8/11/16.
//  Copyright © 2016 erin.a.roby@gmail.com. All rights reserved.
//

#import <Parse/Parse.h>
#import "Show.h"

@interface Piece : PFObject <PFSubclassing>


@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *subtitle;
@property (strong, nonatomic)NSString *desc;
@property (strong, nonatomic)NSString *artist;
@property (strong, nonatomic)NSString *price;
@property (strong, nonatomic)PFFile *image;
@property (strong, nonatomic)PFFile *thumbnail;
@property (strong, nonatomic)PFFile *audio;
@property (strong, nonatomic)NSString *beaconID;

@end
