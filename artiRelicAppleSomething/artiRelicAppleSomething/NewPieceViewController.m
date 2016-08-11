//
//  NewPieceViewController.m
//  artiRelicAppleSomething
//
//  Created by Erin Roby on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "NewPieceViewController.h"

@interface NewPieceViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *pieceImage;
@property (weak, nonatomic) IBOutlet UITextField *pieceTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *pieceArtistTextField;
@property (weak, nonatomic) IBOutlet UITextField *piecePrice;
@property (weak, nonatomic) IBOutlet UITextView *pieceDescription;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *pieceImageTapGesture;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previewButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previewButtonSelected;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UILabel *narrationLabel;
@property (strong, nonatomic) NSURL *soundFileURL;


- (IBAction)pieceImageTapped:(UITapGestureRecognizer *)sender;
- (IBAction)saveButtonPressed:(UIButton *)sender;
- (IBAction)playButtonPressed:(UIButton *)sender;
- (IBAction)stopButtonPressed:(UIButton *)sender;
- (IBAction)recordButtonPressed:(UIButton *)sender;

@end

@implementation NewPieceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *placeholderImage = [UIImage imageNamed:@"frame"];
    self.pieceImage.image = placeholderImage;
    self.title = @"Create Artwork";
    
    //Audio setup
    _playButton.enabled = NO;
    _stopButton.enabled = NO;

    NSArray *dirPaths;
    NSString *docsDir;

    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];

    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"sound.caf"];
    NSLog(@"%@", soundFilePath);

    _soundFileURL = [NSURL fileURLWithPath:soundFilePath];

    NSDictionary *recordSettings  = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithInt:AVAudioQualityMin],
                                     AVEncoderAudioQualityKey,
                                     [NSNumber numberWithInt:16],
                                     AVEncoderBitRateKey,
                                     [NSNumber numberWithInt:2],
                                     AVNumberOfChannelsKey,
                                     [NSNumber numberWithFloat:44100.0],
                                     AVSampleRateKey,
                                     nil];

    NSError *error = nil;

    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];

    _audioRecorder = [[AVAudioRecorder alloc]initWithURL:_soundFileURL settings:recordSettings error:&error];

    if (error) {
        NSLog (@"error: %@", [error localizedDescription]);
    } else {
        [_audioRecorder prepareToRecord];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    
    
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    _recordButton.enabled = YES;
    _stopButton.enabled = YES;
}

- (void) audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    NSLog(@"Decode error occurred");
}

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
}

- (void) audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{
    NSLog(@"Encode error occurred");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)pieceImageTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"Piece Image Tapped");

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
    NSString *title = self.pieceTitleTextField.text;
    NSString *desc = self.pieceDescription.text;
    NSString *artist = self.pieceArtistTextField.text;
    NSString *price = self.piecePrice.text;
    
    if ([title isEqualToString:@""] || !title) {
        [self presentAlert];
    } else {
        Piece *piece = [Piece pieceWithTitle:title desc:desc artist:artist price:price];
        
        piece.audio = [PFFile fileWithData:[NSData dataWithContentsOfURL:_soundFileURL]];
        
        if (self.image) {
            piece.image = [PFFile fileWithData:[[ImageHelper shared]dataFromImage:self.image]];
        }
        if (self.thumb) {
            piece.thumbnail = [PFFile fileWithData:[[ImageHelper shared]dataFromImage:self.thumb]];
        }
        
        [self.show.pieces insertObject:piece atIndex:0];
        self.piece = piece;
        
        NSLog(@"Piece created");
        NSLog(@"Self.piece: %@", self.piece);
        
        [piece save];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"ShowOverviewViewController"]){
        ShowOverviewViewController *showOverviewViewController = [segue destinationViewController];
        showOverviewViewController.show = self.show;
    } else {
    if ([[segue identifier] isEqualToString:@"BeaconPairViewController"]) {
        BeaconPairViewController *beaconPairViewController = [segue destinationViewController];
        beaconPairViewController.piece = self.piece;
        }
    }
}

- (IBAction)playButtonPressed:(UIButton *)sender {
    if (!_audioRecorder.recording) {
        _stopButton.enabled = YES;
        _recordButton.enabled = NO;

        NSError *error;

        _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:_audioRecorder.url error:&error];

        _audioPlayer.delegate = self;
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        } else {
            [_audioPlayer play];
        }
    }
}

- (IBAction)stopButtonPressed:(UIButton *)sender {
    _stopButton.enabled = NO;
    _playButton.enabled = YES;
    _recordButton.enabled = YES;

    if (_audioRecorder.recording){
        [_narrationLabel.layer removeAllAnimations];
        _narrationLabel.textColor = [UIColor blackColor];
        _narrationLabel.text = @"Record Narration";
        [_audioRecorder stop];
    } else if (_audioPlayer.playing) {
        [_audioPlayer stop];
    }
}

- (IBAction)recordButtonPressed:(UIButton *)sender {
    if (!_audioRecorder.recording) {
        _narrationLabel.text = @"RECORDING...";
        _narrationLabel.textColor = [UIColor redColor];
        _narrationLabel.alpha = 0;
        [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            _narrationLabel.alpha = 1;
        } completion:nil];
        _playButton.enabled = NO;
        _stopButton.enabled = YES;
        [_audioRecorder record];
    }
}

- (void)presentAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"WARNING" message:@"Please enter a piece title before saving piece." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:OK];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    self.image = info[UIImagePickerControllerEditedImage];
    self.thumb = [[ImageHelper shared] thumbFromImage:self.image];
    self.pieceImage.image = self.image;

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
