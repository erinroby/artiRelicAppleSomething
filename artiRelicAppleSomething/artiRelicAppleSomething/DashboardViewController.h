//
//  DashboardViewController.h
//  artiRelicAppleSomething
//
//  Created by Erin Roby on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Bolts/Bolts.h>
#import "Curator.h"
#import "Show.h"

@interface DashboardViewController : UIViewController

@property (strong, nonatomic)Show *show;
@property (strong, nonatomic)Curator *curator;

@end
