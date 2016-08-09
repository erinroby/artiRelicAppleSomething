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

- (IBAction)pieceImageTapped:(UITapGestureRecognizer *)sender;
- (IBAction)saveButtonPressed:(UIButton *)sender;

@end

@implementation NewPieceViewController

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


- (IBAction)pieceImageTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"Piece Image Tapped");
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
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

-(Piece*)createPieceWithTitle:(NSString *)title desc:(NSString *)desc artist:(NSString *)artist price:(NSString *)price
{
    Piece *piece = [Piece pieceWithTitle:title desc:desc artist:artist price:price];
    return piece;
}

-(void) savePressed {
    NSString *title = self.pieceTitleTextField.text;
    NSString *desc = self.pieceDescription.text;
    NSString *artist = self.pieceArtistTextField.text;
    NSString *price = self.piecePrice.text;

    if ([title isEqualToString:@""] || !title) {
        [self presentAlert];
    } else {
        Piece *piece = [self createPieceWithTitle:title desc:desc artist:artist price:price];
        self.piece = piece;

        NSLog(@"Piece created: %@", piece);
        NSLog(@"Self.piece: %@", self.piece);

        NSError *error;
        [[NSManagedObjectContext managerContext]save:&error];
        if (error) {
            NSLog(@"Error saving piece: %@", error);
        } else {
            NSLog(@"Succesfully saved piece");
        }
    }
}

@end
