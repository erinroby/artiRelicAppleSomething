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
//    [self.showCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"showCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.showCollectionView.reloadData;
}

-(NSArray *)dataSource {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Show"];
    NSError *error;
    NSArray *results = [[NSManagedObjectContext managerContext]executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Error fetching shows: %@", error);
        return nil;
    } else {
        return results;
    }
}

#pragma MARK - UICollectionViewDelegate methods

#pragma MARK - UICollectionViewDataSource methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

//- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
//}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"showCell" forIndexPath:indexPath];
    // TODO: Configure cell for reals here!

    Show *show = self.dataSource[indexPath.row];
    UIImage *thumb = [UIImage imageWithData:show.image];
    UIImageView *cellImageView = [[UIImageView alloc]initWithFrame:(CGRectMake(0.0, 0.0, 150.0, 150.0))];
    cellImageView.image = thumb;
    [cell.contentView addSubview:cellImageView];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Setup show and other things to be passed along here!
    Show *show = self.dataSource[indexPath.row];
    ShowOverviewViewController *showOverviewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowOverviewViewController"];
    showOverviewViewController.show = show;
    [self.navigationController pushViewController:showOverviewViewController animated:YES];
}

@end
