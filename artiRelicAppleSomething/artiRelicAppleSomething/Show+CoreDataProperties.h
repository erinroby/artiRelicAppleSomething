//
//  Show+CoreDataProperties.h
//  artiRelicAppleSomething
//
//  Created by Jeremy Moore on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Show.h"

NS_ASSUME_NONNULL_BEGIN

@interface Show (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSData *thumbnail;
@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *subtitle;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) Curator *curator;
@property (nullable, nonatomic, retain) NSSet<Piece *> *pieces;

@end

@interface Show (CoreDataGeneratedAccessors)

- (void)addPiecesObject:(Piece *)value;
- (void)removePiecesObject:(Piece *)value;
- (void)addPieces:(NSSet<Piece *> *)values;
- (void)removePieces:(NSSet<Piece *> *)values;

@end

NS_ASSUME_NONNULL_END
