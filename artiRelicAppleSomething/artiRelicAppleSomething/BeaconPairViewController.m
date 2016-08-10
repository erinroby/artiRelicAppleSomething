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

#import "NearestBeaconManager.h"

@interface BeaconPairViewController () <UITableViewDataSource, ProximityContentManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *availableBeacons;

@property (nonatomic) ProximityContentManager *proximityContentManager;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
- (IBAction)saveButtonPressed:(id)sender;

@end

@implementation BeaconPairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    
//    [self.proximityContentManager.nearestBeaconManager setBeaconRegions:nil];
//    self.proximityContentManager.nearestBeaconManager.beaconManager.requestWhenInUseAuthorization;
    
    // this seems expensive to put this here...but it is only called once here?
    // this isn't going to work because I don't know what my Beacons in range are...or do I? Is this hard coded in here for now to populate?
    // there are two ProximityContentManager initializers, the other init with BeaconRegion but you gotta get that region first and assign pointer as argument.
    self.proximityContentManager = [[ProximityContentManager alloc]
                                    initWithBeaconIDs:@[
                                                        [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:7340 minor:18322],
                                                        [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:43557 minor:26950],
                                                        [[BeaconID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" major:32193 minor:28874]
                                                        ]
                                    beaconContentFactory:[[CachingContentFactory alloc] initWithBeaconContentFactory:[BeaconDetailsCloudFactory new]]];
    self.proximityContentManager.delegate = self;
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.proximityContentManager startContentUpdates];
    // setup beacon call to see what beacons are available here.
    // [self fetchBeaconData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.proximityContentManager stopContentUpdates];
}

- (void)proximityContentManager:(ProximityContentManager *)proximityContentManager didUpdateContent:(id)content {
    
    BeaconDetails *beaconDetails = content;
    if (beaconDetails) {
        NSLog(@"%@", beaconDetails);
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
    // send and/or attach beacon data to the piece here.
}

#pragma MARK - Estimote Location Management


#pragma MARK - UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"beaconCell" forIndexPath:indexPath];
//    [self proximityContentManager:self.proximityContentManager didUpdateContent:nil];
//    Beacon *currentBeacon = self.availableBeacons[indexPath.row];
    // make the call to fetch the available beacons here...when is the availableBeacons array set?
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

/*
 estimote docs:
 
 class ViewController: UIViewController, ESTBeaconManagerDelegate  {
 
 // 2. Add the beacon manager and the beacon region
 let beaconManager = ESTBeaconManager()
 let beaconRegion = CLBeaconRegion(
 proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!,
 identifier: "ranged region")
 
 override func viewDidLoad() {
 super.viewDidLoad()
 // 3. Set the beacon manager's delegate
 self.beaconManager.delegate = self
 // 4. We need to request this authorization for every beacon manager
 self.beaconManager.requestAlwaysAuthorization()
 }
 
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
 }
 
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
 }
 
 */
