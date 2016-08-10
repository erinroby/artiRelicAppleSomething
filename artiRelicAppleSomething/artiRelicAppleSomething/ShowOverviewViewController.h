//
//  ShowOverviewViewController.h
//  artiRelicAppleSomething
//
//  Created by Erin Roby on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Show.h"
#import "ImageHelper.h"
#import "Piece.h"
#import "Beacon.h"
#import "NewPieceViewController.h"
#import <Parse/Parse.h>
#import "ShowToPublish.h"
#import "Curator.h"

@interface ShowOverviewViewController : UIViewController

@property(strong, nonatomic)Show *show;

@end
