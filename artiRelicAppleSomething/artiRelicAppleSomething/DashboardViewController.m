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
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showCollectionView.delegate = self;
    self.showCollectionView.dataSource = self;
    [self.showCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSArray *)dataSource {
    // TODO: Hook this up to the core data dataSource!
    UIImage *image = [UIImage imageNamed:@"picasso"];
    UIImage *imageOne = [UIImage imageNamed:@"picasso1"];
    UIImage *imageTwo = [UIImage imageNamed:@"picasso2"];
    
    _dataSource = @[image, imageOne, imageTwo];
    
    return _dataSource;
}

#pragma MARK - UICollectionViewDelegate methods

#pragma MARK - UICollectionViewDataSource methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    // TODO: Configure cell for reals here!
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Setup show and other things to be passed along here!
//    Show *show = self.dataSource[indexPath.row];
    ShowOverviewViewController *showOverviewViewController = [[ShowOverviewViewController alloc]init];
//    showOverviewViewController.show = show;
    [self.navigationController pushViewController:showOverviewViewController animated:YES];
}

@end
