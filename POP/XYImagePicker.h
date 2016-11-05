//
//  XYImagePicker.h
//  POP
//
//  Created by JYRuan on 16/11/4.
//  Copyright © 2016年 Ruan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYImagePickerDelegate <NSObject>

@optional

/**
 设置图片

 @param img 选取的图片
 */
-(void)setImg:(UIImage*) img;

@end

@interface XYImagePicker : UIImage

/**
 代理
 */
@property (nonatomic,weak)id<XYImagePickerDelegate> delegate;


/**
 图片选择
 */
-(void)choosePhoto;

@end
