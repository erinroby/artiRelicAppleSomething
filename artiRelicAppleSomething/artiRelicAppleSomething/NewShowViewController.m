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

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *subtitleTextField;

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

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
}

@end
