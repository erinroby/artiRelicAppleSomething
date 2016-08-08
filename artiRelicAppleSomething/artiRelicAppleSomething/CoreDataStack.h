//
//  CoreDataStack.h
//  artiRelicAppleSomething
//
//  Created by Jeremy Moore on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)shared;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
