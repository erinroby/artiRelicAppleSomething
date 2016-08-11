//
//  Show.h
//  PatronArtiRelic
//
//  Created by Jeremy Moore on 8/11/16.
//  Copyright © 2016 erin.a.roby@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface Show : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) PFFile *image;
@property (strong, nonatomic) PFFile *thumbnail;
@property (strong, nonatomic) NSArray *pieces;

@end
