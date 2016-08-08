//
//  Curator.m
//  artiRelicAppleSomething
//
//  Created by Jeremy Moore on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "Curator.h"
#import "Show.h"

@implementation Curator

+ (instancetype) curatorWithUserName:(NSString *)userName password:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName
{
    Curator *curator = [NSEntityDescription insertNewObjectForEntityForName:@"Curator" inManagedObjectContext:[NSManagedObjectContext managerContext]];
    curator.userName = userName;
    curator.password = password;
    curator.firstName = firstName;
    curator.lastName = lastName;
    
    return curator;
}



@end
