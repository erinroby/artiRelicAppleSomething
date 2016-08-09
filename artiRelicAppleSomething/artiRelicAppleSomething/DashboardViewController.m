//
//  DashboardViewController.m
//  artiRelicAppleSomething
//
//  Created by Erin Roby on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "DashboardViewController.h"
#import "ShowOverviewViewController.h"
#import "Show.h"

@interface DashboardViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *showCollectionView;
@property(strong, nonatomic)NSArray *dataSource;

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showCollectionView.delegate = self;
    self.showCollectionView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSArray *)dataSource {
    if (!_dataSource) {
        // TODO: Replace the following line with the getting for the dataSource. i.e. from Core Data Hotel Assignment: [_datasource = [ReservationService reservationService:self.startDate endDate:self.endDate];]
        _dataSource = nil;
    }
    return _dataSource;
}

#pragma MARK - UICollectionViewDelegate methods

#pragma MARK - UICollectionViewDataSource methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Show *show = self.dataSource[indexPath.row];
    ShowOverviewViewController *showOverviewViewController = [[ShowOverviewViewController alloc]init];
    showOverviewViewController.show = show;
    [self.navigationController pushViewController:showOverviewViewController animated:YES];
}

@end
