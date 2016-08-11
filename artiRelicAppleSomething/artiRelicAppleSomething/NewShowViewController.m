//
//  NewShowViewController.m
//  artiRelicAppleSomething
//
//  Created by Erin Roby on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "NewShowViewController.h"


@interface NewShowViewController () <UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>



@property (weak, nonatomic) IBOutlet UIButton *save;
- (IBAction)savePressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *subtitleTextField;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *headerImageTapGesture;
- (IBAction)headerImageTapped:(UITapGestureRecognizer *)sender;

@end

@implementation NewShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)presentAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"WARNING" message:@"Please enter a show title before saving show." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:OK];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)savePressed:(id)sender
{
    NSString *title = self.titleTextField.text;
    NSString *subtitle = self.subtitleTextField.text;
    NSString *desc = self.descriptionTextField.text;
    
    if ([title  isEqual: @""] || !title) {
        [self presentAlert];
    } else {
        Show *show = [Show publishShowWithTitle:title subtitle:subtitle desc:desc];
        if (self.image) {
            show.image = [PFFile fileWithData:[[ImageHelper shared]dataFromImage:self.image]];;
        }
        if (self.thumb) {
            show.thumbnail = [PFFile fileWithData:[[ImageHelper shared]dataFromImage:self.thumb]];
        }
        show.pieces = [[NSMutableArray alloc]init];
        
        NSLog(@"Show created: %@", show);
        
        [show saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                NSLog(@"Show saved to parse");
            } else {
                NSLog(@"Show failed to save to parse: %@", error);
            }
        }];
    }

}
- (IBAction)headerImageTapped:(UITapGestureRecognizer *)sender
{
    NSLog(@"Show Image Tapped!");

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    self.image = info[UIImagePickerControllerEditedImage];
    self.thumb = [[ImageHelper shared] thumbFromImage:self.image];
    
    self.headerImage.image = self.image;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
