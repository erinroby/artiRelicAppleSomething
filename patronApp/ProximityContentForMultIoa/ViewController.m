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

@interface ViewController () <ProximityContentManagerDelegate, CLLocationManagerDelegate>

- (IBAction)fetchButtonSelected:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *showImage;

@property (nonatomic) ProximityContentManager *proximityContentManager;

@property (nonatomic) ESTBeaconManager *beaconManager;


@end

@implementation ViewController

- (void)viewDidLoad {   
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    self.beaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:proximityUUID major:21640 minor:54671 identifier:@"happy "];
    self.beaconRegion.notifyEntryStateOnDisplay = YES;
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    

//Select show to be hosted by title
    PFQuery *query = [PFQuery queryWithClassName:@"Show"];
    [query whereKey:@"title" equalTo:@"Stuff"];
    [query includeKey:@"pieces"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"show results: %@", objects);
            self.show = [objects firstObject];
            NSLog(@"Show: %@", self.show);
            NSLog(@"Fetching pieces");
            for (id object in self.show.pieces){
                [object fetchIfNeeded];
            }
            
            NSString *showTitle = self.show.title;
            self.welcomeLabel.text = [self.welcomeLabel.text stringByAppendingString:showTitle];
// TODO:  can get artist from show, I forgot to input for this show...
            NSString *artistName = @" B. Watterson";
            self.artistLabel.text = [self.artistLabel.text stringByAppendingString:artistName];
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

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Entered region");
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.alertBody = @"Yay, you entered the Icy Mint region!!";
    notification.alertTitle = @"Monitoring!!!";
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
    NSString *pieceID = region.identifier;
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@",pieceID];
    NSArray *filteredArray = [self.show.pieces filteredArrayUsingPredicate:bPredicate];
    self.piece = [filteredArray firstObject];

    [self performSegueWithIdentifier:@"ApplePayViewController" sender:self];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"ApplePayViewController"]) {
        ApplePayViewController *applePayViewController = [segue destinationViewController];
        applePayViewController.piece = self.piece;
    }
    
}


- (void)proximityContentManager:(ProximityContentManager *)proximityContentManager didUpdateContent:(id)content {
    
    //    [self.proximityContentManager nearestBeaconManager:proximityContentManager.nearestBeaconManager didUpdateNearestBeaconID:nil];
    
    BeaconDetails *beaconDetails = content;
    if (beaconDetails) {
//        NSLog(@"%@", beaconDetails.beaconName);
//        CLBeaconRegion *region = [self.proximityContentManager.beaconId asBeaconRegion];
//        NSLog(@"%@", region);
        self.UIID = self.proximityContentManager.beaconId.description;
//        NSLog(@"self.UIID set to: %@",self.UIID);
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
    // Rather than re-fetch to Parse, we can match the beaconID to a piece we already have attached to the show we initially downloaded.
    NSLog(@"Fetch button pressed");
    
    
    
    NSString *beaconID = self.UIID;
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"beaconID contains[cd] %@",beaconID];
    NSArray *filteredArray = [self.show.pieces filteredArrayUsingPredicate:bPredicate];
    self.piece = [filteredArray firstObject];
    NSLog(@"self.piece: %@",self.piece);
//    PFFile *audioFile = self.piece.audio;
//    NSData *audioData = [audioFile getData];
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    [audioSession setCategory:AVAudioSessionCategorySoloAmbient error:nil];
//    _audioPlayer = [[AVAudioPlayer alloc]initWithData:audioData error:nil];
    
}



@end
