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

NSString const *kUUID = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";

@interface BeaconPairViewController () <UITableViewDataSource, ProximityContentManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) ProximityContentManager *proximityContentManager;
@property (weak, nonatomic) IBOutlet UILabel *UIID;

@property (strong, nonatomic) NSMutableArray *availableBeacons;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
- (IBAction)saveButtonPressed:(id)sender;

@end

@implementation BeaconPairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
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

-(void)contentForBeaconID:(BeaconID *)beaconID completion:(void (^)(id))completion {
    
}

- (void)proximityContentManager:(ProximityContentManager *)proximityContentManager didUpdateContent:(id)content {
    
//    [self.proximityContentManager nearestBeaconManager:proximityContentManager.nearestBeaconManager didUpdateNearestBeaconID:nil];
    
    BeaconDetails *beaconDetails = content;
    if (beaconDetails) {
        NSLog(@"%@", beaconDetails.beaconName);
        CLBeaconRegion *region = [self.proximityContentManager.beaconId asBeaconRegion];
        NSLog(@"%@", region);
        self.UIID.text = self.proximityContentManager.beaconId.description;
        self.view.backgroundColor = beaconDetails.backgroundColor;
        self.tableView.backgroundColor = beaconDetails.backgroundColor;
        [self.tableView reloadData];
    } else {
        NSLog(@"No Beacons in Range");
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveButtonPressed:(id)sender {
    NSLog(@"saveButton pressed.");
    
    // send and/or attach beacon data to the piece here.
    // do setup in prepare for segue and then call here?
    self.beaconID = self.UIID.text;
    NSLog(@"self.beaconID: %@", self.beaconID);
}

#pragma MARK - Estimote Location Management


#pragma MARK - UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"beaconCell" forIndexPath:indexPath];
    // bah! how to get at the beaconDetails from here!
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.availableBeacons.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"NewPieceViewController"]){
        NewPieceViewController *newPieceViewController = [segue destinationViewController];
        newPieceViewController.beaconID = self.UIID.text;
        newPieceViewController.show = self.show;
        NSLog(@"newPieceViewController.beaconID: %@", newPieceViewController.beaconID);
        NSLog(@"newPieceViewController.show: %@", newPieceViewController.show);
        
    }
}

@end

