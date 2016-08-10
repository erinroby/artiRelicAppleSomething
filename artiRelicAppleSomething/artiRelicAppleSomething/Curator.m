//
//  Curator.m
//  artiRelicAppleSomething
//
//  Created by David Swaintek on 8/10/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "Curator.h"

@interface Curator() <PFSubclassing>

@end

@implementation Curator

@synthesize firstName;
@synthesize lastName;
@synthesize userName;
@synthesize password;

+ (void)load {
    
    [self registerSubclass];
    
}

+ (NSString *)parseClassName {
    return @"Curator";
}

+ (instancetype)curatorWithFirstName:(NSString *)firstName lastName:(NSString *)lastName userName:(NSString *)userName password:(NSString *)password {
    Curator *curator = [[Curator alloc]init];
    curator.firstName = firstName;
    curator.lastName = lastName;
    curator.userName = userName;
    curator.password = password;
    
    return curator;
}


@end
