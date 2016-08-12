//
//  NewPieceViewController.m
//  artiRelicAppleSomething
//
//  Created by Erin Roby on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "NewPieceViewController.h"

const NSTimeInterval kScrollViewKeyboardAnimation = 0.25;
const NSTimeInterval kScrollTextViewKeyboardAnimation = 0.50;

@interface NewPieceViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, BeaconPairViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *pieceImage;
@property (weak, nonatomic) IBOutlet UITextField *pieceTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *pieceArtistTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *piecePrice;
@property (weak, nonatomic) IBOutlet UITextView *pieceDescription;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *pieceImageTapGesture;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *beaconButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UILabel *narrationLabel;
@property (strong, nonatomic) NSURL *soundFileURL;
@property (strong, nonatomic) PFFile *audioFile;


- (IBAction)pieceImageTapped:(UITapGestureRecognizer *)sender;
- (IBAction)saveButtonPressed:(UIButton *)sender;
- (IBAction)playButtonPressed:(UIButton *)sender;
- (IBAction)stopButtonPressed:(UIButton *)sender;
- (IBAction)recordButtonPressed:(UIButton *)sender;
- (IBAction)beaconButtonPressed:(UIBarButtonItem *)sender;

@end

@implementation NewPieceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //audio path
    NSArray *dirPaths;
    NSString *docsDir;

    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];

    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"sound.caf"];

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

    //determine new or existing piece
    if (self.piece) {
        self.pieceImage.image = [UIImage imageWithData:[self.piece.image getData]];
        self.title = @"Edit Artwork";
        self.pieceTitleTextField.text = self.piece.title;
        self.pieceArtistTextField.text = self.piece.artist;
        self.piecePrice.text = self.piece.price;
        if (self.piece.audio) {
            [[self.piece.audio getData] writeToURL:_soundFileURL atomically:YES];
            _playButton.enabled = YES;
            _stopButton.enabled = NO;
        }
    } else {
        UIImage *placeholderImage = [UIImage imageNamed:@"frame"];
        self.pieceImage.image = placeholderImage;
        self.title = @"Create Artwork";
        _playButton.enabled = NO;
        _stopButton.enabled = NO;
    }


}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    _recordButton.enabled = YES;
    _stopButton.enabled = NO;
}

- (void) audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    NSLog(@"Decode error occurred");
}

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
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
        Piece *piece;
        if (self.piece) {
            piece = self.piece;
            piece.title = title;
            piece.desc = desc;
            piece.artist = artist;
            piece.price = price;
            piece.beaconID = _beaconID;
            if (self.image) {
                piece.image = [PFFile fileWithData:[[ImageHelper shared]dataFromImage:self.image]];;
            }
            if (self.thumb) {
                piece.thumbnail = [PFFile fileWithData:[[ImageHelper shared]dataFromImage:self.thumb]];
            }
            
            if (_audioFile) {
                piece.audio = _audioFile;
            }
            [piece saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    NSLog(@"Piece saved to parse");
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    NSLog(@"Piece failed to save to parse: %@", error);
                }
            }];
        } else {
            piece = [Piece pieceWithTitle:title desc:desc artist:artist price:price];
            piece.beaconID = _beaconID;
            if (self.image) {
                piece.image = [PFFile fileWithData:[[ImageHelper shared]dataFromImage:self.image]];;
            }
            if (self.thumb) {
                piece.thumbnail = [PFFile fileWithData:[[ImageHelper shared]dataFromImage:self.thumb]];
            }
            
            if (_audioFile) {
                piece.audio = _audioFile;
            }
            self.show.pieces = [[NSMutableArray alloc]init];
            self.show.pieces = [self.show.pieces arrayByAddingObject:piece];
            [self.show saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    NSLog(@"Show with new piece saved to parse");
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    NSLog(@"Show with new piece failed to save to parse: %@", error);
                }
            }];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqualToString: @"BeaconPairViewController"]) {
        BeaconPairViewController *beaconPairVC = segue.destinationViewController;
        beaconPairVC.delegate = self;
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
        _audioFile = [PFFile fileWithData:[NSData dataWithContentsOfURL:_soundFileURL]];
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

- (IBAction)beaconButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"BeaconPairViewController" sender:sender];
};

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

#pragma BeaconPairViewControllerDelegate

-(void)addItemViewController:(BeaconPairViewController *)controller didFinishEnteringItem:(NSString *)item{
    // J: THe item here is the BeaconID string. Do what you need to with it for Parse, please.
    _beaconID = item;
    NSLog(@"This was returned from ViewControllerB %@",item);

}

#pragma mark UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:kScrollViewKeyboardAnimation animations:^{
        [self.scrollView setContentOffset:(CGPointMake(0.0, 50.0))];
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    [UIView animateWithDuration:kScrollViewKeyboardAnimation animations:^{
        [self.scrollView setContentOffset:(CGPointMake(0.0, (45.0 - navBarHeight)))];
    }];
}

#pragma mark UITextViewDelegate

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self.pieceDescription setReturnKeyType:UIReturnKeyDone];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [UIView animateWithDuration:kScrollTextViewKeyboardAnimation animations:^{
        [self.scrollView setContentOffset:(CGPointMake(0.0, 150.0))];
    }];
    
    [self.pieceDescription setReturnKeyType:UIReturnKeyDefault];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    int charINTtyped = 0;
    
    if([text length] > 0){
        charINTtyped = (int)[text characterAtIndex:0];
    }
    
    if(charINTtyped == 10){
        [textView resignFirstResponder];
        [UIView animateWithDuration:kScrollTextViewKeyboardAnimation animations:^{
            CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
            [self.scrollView setContentOffset:(CGPointMake(0.0, (45.0 - navBarHeight)))];
        }];
        return NO;
    }
    return YES;
}


@end
