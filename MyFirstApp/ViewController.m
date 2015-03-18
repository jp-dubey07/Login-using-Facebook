//
//  ViewController.m
//  MyFirstApp
//
//  Created by MACBOOK-MUM on 18/03/15.
//  Copyright (c) 2015 MACBOOK-MUM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.center = self.view.center;
    [self.view addSubview:loginView];
    
}

-(IBAction)shareButtonClicked {

    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithPhotos]) {
        
        // Open the image picker and set this class as the delegate
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setDelegate:self];
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    } else {
        // The user doesn't have the Facebook for iOS app installed.  You
        // may be able to use a fallback.
    }

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    FBPhotoParams *params = [[FBPhotoParams alloc] init];
    
    // Note that params.photos can be an array of images.  In this example
    // we only use a single image, wrapped in an array.
    params.photos = @[img];
    
    [FBDialogs presentShareDialogWithPhotoParams:params
                                     clientState:nil
                                         handler:^(FBAppCall *call,
                                                   NSDictionary *results,
                                                   NSError *error) {
                                             if (error) {
                                                 NSLog(@"Error: %@",
                                                       error.description);
                                             } else {
                                                 NSLog(@"Success!");
                                             }
                                         }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
