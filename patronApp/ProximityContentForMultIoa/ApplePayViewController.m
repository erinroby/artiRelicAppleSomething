//
//  ApplePayViewController.m
//  PatronArtiRelic
//
//  Created by hannah gaskins on 8/9/16.
//  Copyright © 2016 erin.a.roby@gmail.com. All rights reserved.
//

#import "ApplePayViewController.h"

@import Stripe;
@import Parse;

@interface ApplePayViewController ()<PKPaymentAuthorizationViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *applePayButton;
- (IBAction)payPressed:(id)sender;
@property(strong, nonatomic)PKPaymentRequest *request;
@property(strong, nonatomic)NSArray *paymentMethods;
@property(weak, nonatomic)NSString *applePayMerchID;
@property(nonatomic, assign) PKMerchantCapability merchantCapabilities;
@property(nonatomic, copy) NSArray<PKPaymentSummaryItem *> *paymentSummaryItems;
@property (weak, nonatomic) IBOutlet UIImageView *pieceImage;
@property (weak, nonatomic) IBOutlet UITextView *descLabel;
- (IBAction)playButtonPressed:(id)sender;
- (IBAction)pauseButtonPressed:(id)sender;
- (IBAction)rewindButtonPressed:(id)sender;


@end

@implementation ApplePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.piece.title;
    self.descLabel.text = self.piece.desc;
    self.pieceImage.image = [UIImage imageWithData:[self.piece.image getData]];

    
}

- (void)viewWillAppear:(BOOL)animated{
    //Audio setup
    PFFile *audioFile = self.piece.audio;
    NSData *audioData = [audioFile getData];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    _audioPlayer = [[AVAudioPlayer alloc]initWithData:audioData error:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion {
    
    [Stripe setDefaultPublishableKey:@"sk_test_PQ2NH73ti7lbZ9Vx9qXYucFz"];
    [[STPAPIClient sharedClient]createTokenWithPayment:payment completion:^(STPToken * _Nullable token, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@",error.description);
            completion(PKPaymentAuthorizationStatusFailure);
        } else {
            [PFCloud callFunctionInBackground:@"finalizePurchase"
                               withParameters:@{@"cardToken":token.tokenId}
                                        block:^(id  _Nullable object, NSError * _Nullable error) {
                                                if (error) {
                                                    NSLog(@"test😎");
                                                    NSLog(@"%@", error.localizedDescription);
                                                } else {
                                                    NSLog(@"This is the object: %@", object);
                                                }
            }];
            
            [PFCloud callFunctionInBackground:@"hello" withParameters:nil block:^(id  _Nullable object, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"%@", error.localizedDescription);
                } else {
                    NSLog(@"%@", object);
                }
            }];
            
//            [PFCloud callFunctionInBackground:@"hello" withParameters:nil block:^(id  _Nullable object, NSError * _Nullable error) {
//                if (error) {
//                    NSLog(@"%@", error.localizedDescription);
//                } else {
//                    NSLog(@"%@", object);
//                }
//            }];
            
            NSLog(@"%@", token);
            completion(PKPaymentAuthorizationStatusSuccess);
        }
    }];
    
    
//    completion(PKPaymentAuthorizationStatusSuccess);
    
    
}


- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)payPressed:(id)sender {
    
    self.request = [[PKPaymentRequest alloc]init];
    self.paymentMethods = @[PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex];
    self.applePayMerchID = @"merchant.com.patronAppArtiRelic";
    self.request.merchantIdentifier = self.applePayMerchID;
    self.request.supportedNetworks = self.paymentMethods;
    self.request.merchantCapabilities = PKMerchantCapability3DS;
    self.request.countryCode = @"US";
    self.request.currencyCode = @"USD";
    
    // 12.75 subtotal
    NSDecimalNumber *subtotalAmount = [NSDecimalNumber decimalNumberWithMantissa:12250
                                                                        exponent:-2 isNegative:NO];
    self.request.paymentSummaryItems = @[[PKPaymentSummaryItem summaryItemWithLabel:@"Subtotal" amount:subtotalAmount]];
    
    PKPaymentAuthorizationViewController *applePayController = [[PKPaymentAuthorizationViewController alloc]initWithPaymentRequest:self.request];
    [self presentViewController:applePayController animated:YES completion:nil];
    applePayController.delegate = self;
    
}
- (IBAction)playButtonPressed:(id)sender {
    [_audioPlayer play];
}

- (IBAction)pauseButtonPressed:(id)sender {
    [_audioPlayer pause];
}

- (IBAction)rewindButtonPressed:(id)sender {
    [_audioPlayer setCurrentTime:0];
}
@end
























