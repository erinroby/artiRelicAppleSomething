//
//  NewShowViewController.m
//  artiRelicAppleSomething
//
//  Created by Erin Roby on 8/8/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "NewShowViewController.h"

@interface NewShowViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIButton *save;
- (IBAction)savePressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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


- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    
    //TODO: add form validation, check for values in text fields
    NSString *title = self.titleTextField.text;
    NSString *subtitle = self.subtitleTextField.text;
    Show *show = [self createShow:title subtitle:subtitle];
    self.show = show;
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

- (IBAction)savePressed:(id)sender {
}
- (IBAction)headerImageTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"Show Image Tapped!");
}
@end
