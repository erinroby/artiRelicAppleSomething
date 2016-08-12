//
// Please report any problems with this app template to contact@estimote.com
//

#import <UIKit/UIKit.h>
#import "Show.h"
#import "Piece.h"
#import "ApplePayViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>


@interface ViewController : UIViewController

@property (strong, nonatomic)Show *show;
@property (strong, nonatomic)Piece *piece;
@property (strong, nonatomic)NSString *UIID;

@property (strong, nonatomic)CLBeaconRegion *beaconRegion;
@property (strong, nonatomic)CLLocationManager *locationManager;

@end
