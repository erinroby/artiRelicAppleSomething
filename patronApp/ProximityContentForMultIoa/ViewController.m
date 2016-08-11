//
// Please report any problems with this app template to contact@estimote.com
//

#import "ViewController.h"
#import <EstimoteSDK/EstimoteSDK.h>
#import "BeaconDetails.h"
#import "BeaconID.h"
#import "BeaconDetailsCloudFactory.h"
#import "CachingContentFactory.h"
#import "ProximityContentManager.h"
#import "NearestBeaconManager.h"

@import Parse;

@interface ViewController () <ProximityContentManagerDelegate>
- (IBAction)fetchButtonSelected:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *showImage;

@property (nonatomic) ProximityContentManager *proximityContentManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFQuery *query = [PFQuery queryWithClassName:@"Show"];
    [query whereKey:@"title" equalTo:@"Flower"];
    [query includeKey:@"pieces"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.show = [objects firstObject];
            NSLog(@"Show: %@", self.show.pieces);
            NSString *showTitle = self.show.title;
            self.welcomeLabel.text = [self.welcomeLabel.text stringByAppendingString:showTitle];
            UIImage *showImage = [UIImage imageWithData:[self.show.image getData]];
            self.showImage.image = showImage;
            self.descriptionLabel.text = self.show.desc;
        } else {
            NSLog(@"Error: failed to load parse-- %@",error);
        }
    }];

    
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
}

- (void)proximityContentManager:(ProximityContentManager *)proximityContentManager didUpdateContent:(id)content {
    
    //    [self.proximityContentManager nearestBeaconManager:proximityContentManager.nearestBeaconManager didUpdateNearestBeaconID:nil];
    
    BeaconDetails *beaconDetails = content;
    if (beaconDetails) {
        NSLog(@"%@", beaconDetails.beaconName);
        CLBeaconRegion *region = [self.proximityContentManager.beaconId asBeaconRegion];
        NSLog(@"%@", region);
        NSString *beaconID = self.proximityContentManager.beaconId.description;
        PFQuery *innerQuery = [PFQuery queryWithClassName:@"Piece"];
        [innerQuery whereKey:@"beaconID" equalTo:beaconID];
        PFQuery *query = [PFQuery queryWithClassName:@"Show"];
        [query whereKey:@"pieces" matchesQuery:innerQuery];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"%@",objects.firstObject);
            } else {
                NSLog(@"Error fetching piece: %@", error);
            }
        }];
    } else {
        NSLog(@"No Beacons in Range");
        
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.proximityContentManager stopContentUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fetchButtonSelected:(id)sender
{
    NSLog(@"Fetch button pressed");
    NSString *ID = @"Label";
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"beaconID contains[cd] %@",ID];
    NSArray *filteredArray = [self.show.pieces filteredArrayUsingPredicate:bPredicate];
    NSLog(@"filterArray: %@",filteredArray);
    
}
@end
