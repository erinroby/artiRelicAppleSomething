//
//  BeaconPairViewController.m
//  artiRelicAppleSomething
//
//  Created by Erin Roby on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "BeaconPairViewController.h"
#import <EstimoteSDK/EstimoteSDK.h>

// Estomote
#import "BeaconDetails.h"
#import "BeaconID.h"
#import "BeaconDetailsCloudFactory.h"
#import "CachingContentFactory.h"

#import "NearestBeaconManager.h"

@interface BeaconPairViewController () <ProximityContentManagerDelegate>

@property (nonatomic) ProximityContentManager *proximityContentManager;
@property (weak, nonatomic) IBOutlet UILabel *UIID;

@end

@implementation BeaconPairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Choose Beacon";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.proximityContentManager = [[ProximityContentManager alloc]
                                    initWithBeaconIDs:@[
                                                        [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:21640 minor:54671],
                                                        [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:9784 minor:6682],
                                                        [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:36360 minor:36995],
                                                        [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:7340 minor:18322],
                                                        [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:43557 minor:26950],
                                                        [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:32193 minor:28874]
                                                        ]
                                    beaconContentFactory:[[CachingContentFactory alloc] initWithBeaconContentFactory:[BeaconDetailsCloudFactory new]]];
    self.proximityContentManager.delegate = self;
    [self.proximityContentManager startContentUpdates];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.proximityContentManager stopContentUpdates];
}

- (void)proximityContentManager:(ProximityContentManager *)proximityContentManager didUpdateContent:(id)content {
    BeaconDetails *beaconDetails = content;
    if (beaconDetails) {
        CLBeaconRegion *region = [self.proximityContentManager.beaconId asBeaconRegion];
        NSLog(@"%@", region);
        // self.UIID.text = self.proximityContentManager.beaconId.description;
        self.UIID.text = beaconDetails.beaconName;
        // write a switch statement to handle the image, etc.
        self.view.backgroundColor = beaconDetails.backgroundColor;
    } else {
        self.UIID.text = @"No Beacons in Range";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"NewPieceViewController"]){
        NewPieceViewController *newPieceViewController = [segue destinationViewController];
        newPieceViewController.beaconID = self.proximityContentManager.beaconId.asString;
        // newPieceViewController.beaconID = self.UIID.text;
        // the above can't be tied to a label text because the label text is sometimes not an id.
    }
}

@end

