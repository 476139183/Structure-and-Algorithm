//
//  NLViewController.m
//  NLImageCropper
//
// Copyright © 2012, Mirza Bilal (bilal@mirzabilal.com)
// All rights reserved.
//  Permission is hereby granted, free of charge, to any person obtaining a copy
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
// 1.	Redistributions of source code must retain the above copyright notice,
//       this list of conditions and the following disclaimer.
// 2.	Redistributions in binary form must reproduce the above copyright notice,
//       this list of conditions and the following disclaimer in the documentation
//       and/or other materials provided with the distribution.
// 3.	Neither the name of Mirza Bilal nor the names of its contributors may be used
//       to endorse or promote products derived from this software without specific
//       prior written permission.
// THIS SOFTWARE IS PROVIDED BY MIRZA BILAL "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL MIRZA BILAL BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
// IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
// ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "NLViewController.h"
#import "UIButton+Bootstrap.h"

@interface NLViewController ()

@end

@implementation NLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _imageCropper = [[NLImageCropperView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_imageCropper];
    
    choseImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    choseImageButton.frame = CGRectMake(SCREEN_CGSIZE_HEIGHT - 70 - 140, 30, 135, 30);
//    choseImageButton.layer.cornerRadius = 4.0;
    [choseImageButton setTitle:NSLocalizedString(@"YunPing_SelectPhoto", @"选取图片") forState:UIControlStateNormal];
    [choseImageButton setBackgroundColor:[UIColor colorWithWhite:0.800 alpha:1.000]];
    [choseImageButton setBackgroundImage:[UIImage imageNamed:@"aboutDesigner_bg_pressed"] forState:UIControlStateHighlighted];
//    [choseImageButton primaryStyle];
    [choseImageButton addTarget:self action:@selector(choseImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choseImageButton];
    
    [_imageCropper setCropRegionRect:CGRectMake(512 - 80, 20, 160, 640)];
#ifndef ARC
    [_imageCropper release];
#endif
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)choseImage
{
    actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"YunPing_SelectPhoto", @"选取图片") delegate:self cancelButtonTitle:nil destructiveButtonTitle:NSLocalizedString(@"NSString17", @"取消") otherButtonTitles:NSLocalizedString(@"YunPing_SelectPhotoFromAlbum", @"从相册选取"), NSLocalizedString(@"YunPing_TakePhoto", @"拍照"), nil];//@"选择" @"取消"  @"从相册选择"
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    else if (buttonIndex == 1)
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
        popover.delegate = self;
        [popover presentPopoverFromRect:CGRectMake(SCREEN_CGSIZE_HEIGHT - 140, 30, 135, 30) inView:self.view.window.rootViewController.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
        [imagePickerController release];
    }
    else if (buttonIndex == 2) {
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
//        [self.navigationController presentViewController:imagePickerController animated:YES completion:^{}];
        [self.view.window.rootViewController presentViewController:imagePickerController animated:YES completion:nil];
        
        [imagePickerController release];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    DLog(@"%@",info);
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
    }];
    [_imageCropper setImage:[info objectForKey:UIImagePickerControllerEditedImage]];
}
#pragma mark - UIPopoverControllerDelegate
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
