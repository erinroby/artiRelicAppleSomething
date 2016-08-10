//
// Please report any problems with this app template to contact@estimote.com
//

#import <Foundation/Foundation.h>

#import "BeaconID.h"

@class NearestBeaconManager;

@protocol NearestBeaconManagerDelegate <NSObject>

- (void)nearestBeaconManager:(NearestBeaconManager *)nearestBeaconManager didUpdateNearestBeaconID:(BeaconID *)beaconID;

@end

@interface NearestBeaconManager : NSObject

@property (weak, nonatomic) id<NearestBeaconManagerDelegate> delegate;

@property (copy, nonatomic) NSArray *beaconRegions;
@property (nonatomic) ESTBeaconManager *beaconManager;
@property (nonatomic) BeaconID *nearestBeaconID;
@property (nonatomic) NSMutableArray *beacons;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithBeaconRegions:(NSArray *)beaconRegions NS_DESIGNATED_INITIALIZER;

- (void)startNearestBeaconUpdates;
- (void)stopNearestBeaconUpdates;
- (void)beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region;

@end
