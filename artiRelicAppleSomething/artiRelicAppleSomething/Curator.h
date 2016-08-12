//
//  Curator.h
//  artiRelicAppleSomething
//
//  Created by David Swaintek on 8/10/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <Parse/Parse.h>

@interface Curator : PFObject

@property (strong, nonatomic)NSString *firstName;
@property (strong, nonatomic)NSString *lastName;
@property (strong, nonatomic)NSString *userName;
@property (strong, nonatomic)NSString *password;

+ (instancetype)curatorWithFirstName:(NSString *)firstName lastName:(NSString *)lastName userName:(NSString *)userName password:(NSString *)password;

@end