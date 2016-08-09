//
//  NSManagedObjectContext+NSManagedObjectContext.m
//  artiRelicAppleSomething
//
//  Created by Jeremy Moore on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "NSManagedObjectContext+NSManagedObjectContext.h"

@implementation NSManagedObjectContext (NSManagedObjectContext)

+ (NSManagedObjectContext *)managerContext
{
    return [[CoreDataStack shared]managedObjectContext];
}

@end
