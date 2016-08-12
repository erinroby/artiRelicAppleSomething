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

@end

@implementation ShowOverviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pieceCollectionView.delegate = self;
    self.pieceCollectionView.dataSource = self;
    self.title = self.show.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.pieceCollectionView reloadData];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
}

-(NSArray *)dataSource {
    if (!self.show.pieces) {
        // TODO: Handle what happens when there are no pieces in a show. The view crashes when this array is nil.
        return self.show.pieces;
    }
    return self.show.pieces;
}

- (IBAction)editButtonSelected:(id)sender {
    NewShowViewController *showViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewShowViewController"];
    showViewController.show = self.show;
    [self.navigationController pushViewController:showViewController animated:YES];
    
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
    UIImage *thumb = [UIImage imageWithData:[piece.thumbnail getData]];
    cellImageView.image = thumb;
    [cell.contentView addSubview:cellImageView];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Setup show and other things to be passed along here!
    Piece *piece = self.dataSource[indexPath.row];
    NewPieceViewController *pieceViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewPieceViewController"];
    pieceViewController.show = self.show;
    pieceViewController.piece = piece;
    
    [self.navigationController pushViewController:pieceViewController animated:YES];
}

- (IBAction)publishButtonSelected:(UIBarButtonItem *)sender {
    if (self.show)
    {
//        Show *saveThisShow = self.show;
        
        NSLog(@"Saving show: %@",self.show);
        [self.show saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                NSLog(@"Show saved");
            } else {
                NSLog(@"Error saving show %@", error);
            }
        }];
    }
}


         
@end




