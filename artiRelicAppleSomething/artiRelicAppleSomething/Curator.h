//
//  Curator.h
//  artiRelicAppleSomething
//
//  Created by Jeremy Moore on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataStack.h"
#import "NSManagedObjectContext+NSManagedObjectContext.h"


@class Show;

NS_ASSUME_NONNULL_BEGIN

@interface Curator : NSManagedObject

+ (instancetype) curatorWithUserName:(NSString *)userName password:(NSString *)password firstName:(NSString *)firstName lastName:(NSString *)lastName;

@end


NS_ASSUME_NONNULL_END

#import "Curator+CoreDataProperties.h"
