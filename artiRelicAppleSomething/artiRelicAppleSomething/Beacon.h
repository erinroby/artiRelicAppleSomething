//
//  Beacon.h
//  artiRelicAppleSomething
//
//  Created by David Swaintek on 8/10/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <Parse/Parse.h>

@interface Beacon : PFObject <PFSubclassing>

@property (strong, nonatomic)NSString *uiid;
@property (strong, nonatomic)NSString *major;
@property (strong, nonatomic)NSString *minor;

@end
