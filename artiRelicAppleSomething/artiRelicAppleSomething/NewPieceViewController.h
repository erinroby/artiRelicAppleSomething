//
//  NewPieceViewController.h
//  artiRelicAppleSomething
//
//  Created by Erin Roby on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"
#import "NSManagedObjectContext+NSManagedObjectContext.h"
#import "Curator.h"
#import "Show.h"
#import "Piece.h"

@interface NewPieceViewController : UIViewController

@property (strong, nonatomic)Show *show;
@property (strong, nonatomic)Curator *curator;
@property (strong, nonatomic)Piece *piece;

@end
