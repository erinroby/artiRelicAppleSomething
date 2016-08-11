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
@property (strong, nonatomic) BFTask *parseShows;

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showCollectionView.delegate = self;
    self.showCollectionView.dataSource = self;
//    PFQuery *query = [PFQuery queryWithClassName:@"Show"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            self.dataSource = objects;
//            [self.showCollectionView reloadData];
//            NSLog(@"Should have reloaded data from viewDidLoad");
//        } else {
//            NSLog(@"Error: failed to load parse");
//        }
//    }];
//    PFQuery *query = [PFQuery queryWithClassName:@"Show"];
//    [[[query findObjectsInBackground]continueWithSuccessBlock:^id _Nullable(BFTask * _Nonnull t) {
//        NSArray *results = t.result;
//        NSMutableArray *saveTasks = [NSMutableArray arrayWithCapacity:[results count]];
//        return [BFTask taskForCompletionOfAllTasks:saveTasks];
//    }] continueWithExecutor:[BFExecutor mainThreadExecutor]withSuccessBlock:^id _Nullable(BFTask * _Nonnull t) {
//        self.dataSource = t.result;
//        self.showCollectionView.reloadData;
//        return t;
//    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    PFQuery *query = [PFQuery queryWithClassName:@"Show"];
    [query includeKey:@"pieces"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Fetched shows from Parse");
            self.dataSource = objects;
            [self.showCollectionView reloadData];
        } else {
            NSLog(@"Error: failed to load parse-- %@",error);
        }
    }];

    [self.showCollectionView reloadData];
    NSLog(@"Should have reloaded from viewWillAppear");
}


#pragma MARK - UICollectionViewDelegate methods

#pragma MARK - UICollectionViewDataSource methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"showCell" forIndexPath:indexPath];
    // TODO: Configure cell for reals here!

    Show *show = self.dataSource[indexPath.row];
    UIImageView *cellImageView = [[UIImageView alloc]initWithFrame:(CGRectMake(0.0, 0.0, 150.0, 150.0))];
    cellImageView.contentMode = UIViewContentModeScaleAspectFit;
    PFFile *pfThumb = show.thumbnail;
    [pfThumb getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!data) {
            return NSLog(@"Error getting PFFile for thumbnail");
        }
        cellImageView.image = [UIImage imageWithData:data];
    }];

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
