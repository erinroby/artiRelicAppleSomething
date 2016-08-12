//
//  BeaconPairViewController.h
//  artiRelicAppleSomething
//
//  Created by Erin Roby on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProximityContentManager.h"
#import "Piece.h"
#import "NewPieceViewController.h"
#import "Show.h"

@class BeaconPairViewController;

@protocol BeaconPairViewControllerDelegate <NSObject>
- (void)addItemViewController:(BeaconPairViewController *)controller didFinishEnteringItem:(NSString *)item;
@end

@interface BeaconPairViewController : UIViewController

@property (strong, nonatomic)Piece *piece;
@property (strong, nonatomic)NSString *beaconID;
@property (strong, nonatomic)Show *show;

@property (nonatomic, weak) id <BeaconPairViewControllerDelegate> delegate;

@end
