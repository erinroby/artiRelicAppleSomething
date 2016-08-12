//
//  NewShowViewController.m
//  artiRelicAppleSomething
//
//  Created by Erin Roby on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "NewShowViewController.h"


@interface NewShowViewController () <UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *save;
- (IBAction)savePressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *subtitleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *headerImageTapGesture;
- (IBAction)headerImageTapped:(UITapGestureRecognizer *)sender;


@end

@implementation NewShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.descriptionTextField.delegate = self;

    if (self.show) {
        self.headerImage.image = [UIImage imageWithData:[self.show.image getData]];
        self.titleTextField.text = self.show.title;
        self.subtitleTextField.text = self.show.subtitle;
        self.descriptionTextField.text = self.show.desc;
        self.title = @"Edit Show";
    } else {
        UIImage *placeholderImage = [UIImage imageNamed:@"frame"];
        self.headerImage.image = placeholderImage;
        self.title = @"Create Show";
    }


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
        Show *show;
        if (self.show) {
            show = self.show;
            show.title = title;
            show.subtitle = subtitle;
            show.desc = desc;
        } else {
            show = [Show publishShowWithTitle:title subtitle:subtitle desc:desc];
            show.pieces = [[NSMutableArray alloc]init];
        }
        if (self.image) {
            show.image = [PFFile fileWithData:[[ImageHelper shared]dataFromImage:self.image]];;
        }
        if (self.thumb) {
            show.thumbnail = [PFFile fileWithData:[[ImageHelper shared]dataFromImage:self.thumb]];
        }
        
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

#pragma mark UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:(CGPointMake(0.0, 50.0))];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    [self.scrollView setContentOffset:(CGPointMake(0.0, (45.0 - navBarHeight)))];
}

#pragma mark UITextViewDelegate

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self.descriptionTextField setReturnKeyType:UIReturnKeyDone];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self.scrollView setContentOffset:(CGPointMake(0.0, 150.0))];
    [self.descriptionTextField setReturnKeyType:UIReturnKeyDefault];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    int charINTtyped = 0;
    
    if([text length] > 0){
        charINTtyped = (int)[text characterAtIndex:0];
    }
    
    if(charINTtyped == 10){
        [textView resignFirstResponder];
        
        CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
        [self.scrollView setContentOffset:(CGPointMake(0.0, (45.0 - navBarHeight)))];
        
        return NO;
    }
    return YES;
}


@end
