//
//  Show.h
//  artiRelicAppleSomething
//
//  Created by Jeremy Moore on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataStack.h"
#import "NSManagedObjectContext+NSManagedObjectContext.h"

@class Curator, Piece;

NS_ASSUME_NONNULL_BEGIN

@interface Show : NSManagedObject

+ (instancetype)showWithTitle:(NSString *)title subtitle:(NSString *)subtitle desc:(NSString *)desc;

@end

NS_ASSUME_NONNULL_END

#import "Show+CoreDataProperties.h"
