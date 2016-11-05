//
//  XYImagePicker.m
//  POP
//
//  Created by JYRuan on 16/11/4.
//  Copyright © 2016年 Ruan. All rights reserved.
//

#import "XYImagePicker.h"

@interface XYImagePicker () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,strong)UIImage *img;
@property (nonatomic,strong)UIImagePickerController *imagePicker;

@end

@implementation XYImagePicker

-(void)choosePhoto{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Choose" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //    相册
    UIAlertAction *photoLib = [UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self photoWith:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    //    相机
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self photoWith:UIImagePickerControllerSourceTypeCamera];
    }];
    //    取消
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    
    [alertVC addAction:photoLib];
    [alertVC addAction:camera];
    [alertVC addAction:cancel];
    
    [(UIViewController*)self.delegate presentViewController:alertVC animated:NSCalendarUnitYearForWeekOfYear completion:^{
    }];
}

/**
 选择图片
 
 @param type UIImagePickerController类型
 */
-(void) photoWith:(UIImagePickerControllerSourceType)type{
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        self.imagePicker = [[UIImagePickerController alloc]init];
        self.imagePicker.sourceType = type;
        self.imagePicker.allowsEditing = YES;
        [(UIViewController*)self.delegate presentViewController:self.imagePicker animated:YES completion:^{
            self.imagePicker.delegate = self;
        }];
    }
    else
    {
        NSLog(@"图片选择不可用");
    }
}


#pragma mark - delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.img = info[@"UIImagePickerControllerEditedImage"];
    if ([self.delegate respondsToSelector:@selector(setImg:)]) {
        [self.delegate setImg:self.img];
        //        NSLog(@"%@",info);
    }
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}


@end
