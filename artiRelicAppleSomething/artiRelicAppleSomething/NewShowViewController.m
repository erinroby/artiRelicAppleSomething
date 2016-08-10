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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(Show *)createShow:(NSString *)title subtitle:(NSString *)subtitle
{
    
    Show *show = [Show showWithTitle:title subtitle:subtitle desc:@""];
    return show;
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
        Show *show = [Show showWithTitle:title subtitle:subtitle desc:desc];
        if (self.image) {
            show.image = [[ImageHelper shared]dataFromImage:self.image];
        }
        if (self.thumb) {
            show.thumbnail = [[ImageHelper shared]dataFromImage:self.thumb];
        }
        
        NSLog(@"Show created: %@", show);
        NSLog(@"Self.show: %@", self.show);
        
        NSError *error;
        [[NSManagedObjectContext managerContext]save:&error];
        if (error) {
            NSLog(@"Error saving show: %@", error);
        } else {
            NSLog(@"Succesfully saved show");
        }
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

    self.image = info[UIImagePickerControllerOriginalImage];
    self.thumb = [[ImageHelper shared] thumbFromImage:self.image];
    
    self.headerImage.image = self.image;
    
    NSError *error;
    [[NSManagedObjectContext managerContext] save:&error];
    if (error) {
        NSLog(@"Error saving image: %@", error);
    } else {
        NSLog(@"Saved image, error code: %@", error);
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
