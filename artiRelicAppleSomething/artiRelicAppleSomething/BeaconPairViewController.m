//
//  BeaconPairViewController.m
//  artiRelicAppleSomething
//
//  Created by Erin Roby on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "BeaconPairViewController.h"
#import "Beacon.h"

@interface BeaconPairViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *availableBeacons;

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
    // setup beacon call to see what beacons are available here.
    //
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveButtonPressed:(id)sender {
    
}

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
