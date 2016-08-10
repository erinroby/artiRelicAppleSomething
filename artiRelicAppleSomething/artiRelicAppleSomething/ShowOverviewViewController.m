//
//  ShowOverviewViewController.m
//  artiRelicAppleSomething
//
//  Created by Erin Roby on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "ShowOverviewViewController.h"

@interface ShowOverviewViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *pieceCollectionView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
- (IBAction)editButtonSelected:(id)sender;
@property(strong, nonatomic)NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *publishButton;
- (IBAction)publishButtonSelected:(UIBarButtonItem *)sender;

@end

@implementation ShowOverviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pieceCollectionView.delegate = self;
    self.pieceCollectionView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.pieceCollectionView.reloadData;

}


-(NSArray *)dataSource {
    return [self.show.pieces allObjects];
}

- (IBAction)editButtonSelected:(id)sender {
}

#pragma mark Prepare for Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"NewPieceViewController"]) {
        NewPieceViewController *newPieceViewController = [segue destinationViewController];
        newPieceViewController.show = self.show;
    }
}

#pragma MARK - UICollectionViewDelegate methods

#pragma MARK - UICollectionViewDataSource methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pieceCell" forIndexPath:indexPath];
    
    UIImageView *cellImageView = [[UIImageView alloc]initWithFrame:(CGRectMake(0.0, 0.0, 150.0, 150.0))];
    Piece *piece = self.dataSource[indexPath.row];
    UIImage *thumb = [UIImage imageWithData:piece.image];
    cellImageView.image = thumb;
    [cell.contentView addSubview:cellImageView];
    
    return cell;
}

- (IBAction)publishButtonSelected:(UIBarButtonItem *)sender {
    if (self.show)
    {
        ShowToPublish *showToPublish = [ShowToPublish publishShowWithTitle:self.show.title subtitle:self.show.subtitle desc:self.show.desc];
        showToPublish.curator = self.show.curator;
        showToPublish.image = self.show.image;
        showToPublish.pieces = [self.show.pieces allObjects];
       
        
        
        [showToPublish saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                NSLog(@"Show published!!");
            } else {
                NSLog(@"Error publishing show: %@", error);
            }
        }];
        
    }
}

@end




