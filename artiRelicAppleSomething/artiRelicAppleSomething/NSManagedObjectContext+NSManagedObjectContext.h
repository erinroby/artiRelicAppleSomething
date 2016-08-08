//
//  NSManagedObjectContext+NSManagedObjectContext.h
//  artiRelicAppleSomething
//
//  Created by Jeremy Moore on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "CoreDataStack.h"

@interface NSManagedObjectContext (NSManagedObjectContext)

+ (NSManagedObjectContext *)managerContext;

@end
