//
//  BeaconPairViewController.m
//  artiRelicAppleSomething
//
//  Created by Erin Roby on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "BeaconPairViewController.h"
#import "Beacon.h"
#import <EstimoteSDK/EstimoteSDK.h>

// Estomote
#import "BeaconDetails.h"
#import "BeaconDetailsCloudFactory.h"
#import "CachingContentFactory.h"
#import "ProximityContentManager.h"

@interface BeaconPairViewController () <UITableViewDataSource, ProximityContentManagerDelegate>

@property (nonatomic) ProximityContentManager *proximityContentManager;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *availableBeacons;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
- (IBAction)saveButtonPressed:(id)sender;

@end

@implementation BeaconPairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    
    // this seems expensive to put this here...but it is only called once here?
    self.proximityContentManager = [[ProximityContentManager alloc]
                                    initWithBeaconIDs:@[
                                                        [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:7340 minor:18322],
                                                        [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:43557 minor:26950],
                                                        [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:32193 minor:28874]
                                                        ]
                                    beaconContentFactory:[[CachingContentFactory alloc] initWithBeaconContentFactory:[BeaconDetailsCloudFactory new]]];
    self.proximityContentManager.delegate = self;
    
    [self.proximityContentManager startContentUpdates];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // setup beacon call to see what beacons are available here.
    // [self fetchBeaconData];
}

- (void)proximityContentManager:(ProximityContentManager *)proximityContentManager didUpdateContent:(id)content {
//    [self.activityIndicator stopAnimating];
//    [self.activityIndicator removeFromSuperview];
    
    BeaconDetails *beaconDetails = content;
    if (beaconDetails) {
//        self.view.backgroundColor = beaconDetails.backgroundColor;
//        self.label.text = [NSString stringWithFormat:@"You're in %@'s range!", beaconDetails.beaconName];
//        self.image.hidden = NO;
    } else {
//        self.view.backgroundColor = BeaconDetails.neutralColor;
//        self.label.text = @"No beacons in range.";
//        self.image.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveButtonPressed:(id)sender {
    
}

#pragma MARK - Estimote Location Management


#pragma MARK - UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"beaconCell" forIndexPath:indexPath];
    Beacon *currentBeacon = self.availableBeacons[indexPath.row];
    // do any cell formatting here.
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.availableBeacons.count;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
