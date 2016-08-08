//
//  Beacon.h
//  artiRelicAppleSomething
//
//  Created by Jeremy Moore on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataStack.h"
#import "NSManagedObjectContext+NSManagedObjectContext.h"

@class Piece;

NS_ASSUME_NONNULL_BEGIN

@interface Beacon : NSManagedObject

+ (instancetype)beaconWithUIID: (NSString *)uiid major:(NSString *)major minor:(NSString *)minor;

@end

NS_ASSUME_NONNULL_END

#import "Beacon+CoreDataProperties.h"
