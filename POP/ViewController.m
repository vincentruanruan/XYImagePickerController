//
//  ViewController.m
//  POP
//
//  Created by JYRuan on 16/11/4.
//  Copyright © 2016年 Ruan. All rights reserved.
//

#import "ViewController.h"
#import <POP.h>
#import "XYImagePicker.h"

@interface ViewController ()<XYImagePickerDelegate>

@property (nonatomic,strong)UIView *midview;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBtn;
@property (nonatomic,strong)UIButton *btn;


/**
 图片选择器
 */
@property (nonatomic,strong)XYImagePicker *imgPick;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)setup{
    [self.view addSubview:self.midview];
    self.btn = [[UIButton alloc]initWithFrame:self.midview.frame];
    [self.btn setTitle:@"lala" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(spring) forControlEvents:UIControlEventTouchUpInside];
    [self.midview addSubview:self.btn];
}

- (IBAction)showOrHide:(id)sender {
    self.midview.hidden ? [self show] : [self hide];
}

/**
 pop动画
 */
-(void)spring{
    
    POPSpringAnimation *animat = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
    animat.springSpeed = 5.f;
    animat.springBounciness = 4.f;
    animat.toValue = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0  blue:arc4random_uniform(256)/255.0  alpha:1];
    
    
    POPSpringAnimation *animat2 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    animat2.springBounciness = 3.f;
    animat2.springSpeed = 1.f;
    animat2.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.2f, 1.2f)];
    animat2.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [animat2 setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
        NSLog(@"%@",@"haha");
        [self.imgPick choosePhoto];
    }];
    
    
    [self.midview pop_addAnimation:animat forKey:@"backgroundColor"];
    [self.midview pop_addAnimation:animat2 forKey:@"scaleXY"];
}

/**
 显示
 */
-(void)show{
    [self.rightBtn setTitle:@"HIDE"];
    self.midview.hidden = NO;
    POPSpringAnimation *animat = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    animat.toValue = [NSValue valueWithCGPoint:self.view.center];
    CGFloat x = self.view.center.x;
    CGFloat y = CGRectGetMaxY(self.view.frame) + CGRectGetHeight(self.midview.frame);
    CGPoint fromPoint = CGPointMake(x, y);
    animat.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animat.springSpeed = 5.f;
    animat.springBounciness = 8.f;
    [animat setCompletionBlock:^(POPAnimation *ani, BOOL res) {
    }];
    
    [self.midview pop_addAnimation:animat forKey:@"showCenter"];
    
}

/**
 隐藏
 */
-(void)hide{
    [self.rightBtn setTitle:@"SHOW"];
    POPSpringAnimation *animat = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat x = self.view.center.x;
    CGFloat y = CGRectGetMaxY(self.view.frame) + CGRectGetHeight(self.midview.frame);
    CGPoint toPoint = CGPointMake(x, y);
    animat.toValue = [NSValue valueWithCGPoint:toPoint];
    animat.springSpeed = 5.f;
    animat.springBounciness = 8.f;
    [animat setCompletionBlock:^(POPAnimation *ani, BOOL res) {
        self.midview.hidden = YES;
    }];
    
    [self.midview pop_addAnimation:animat forKey:@"hideCenter"];
}


#pragma mark - delegate

-(void)setImg:(UIImage *)img{
    [self.btn setImage:img forState:UIControlStateNormal];
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:img]];
}


#pragma mark - 懒加载

-(UIView *)midview
{
    if (_midview == nil) {
        _midview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        [_midview setBackgroundColor: [UIColor redColor]];
        _midview.layer.cornerRadius = CGRectGetWidth(self.midview.frame) * 0.5
        ;
        _midview.layer.masksToBounds = YES;
        _midview.hidden = YES;
        //        //        添加手势
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(spring)];
        //        [_midview addGestureRecognizer:tap];
        //        [_midview hitTest:CGPointZero withEvent:nil];
    }
    return _midview;
}

-(XYImagePicker *)imgPick
{
    if (_imgPick == nil) {
        _imgPick = [[XYImagePicker alloc]init];
        _imgPick.delegate = self;
    }
    return _imgPick;
}

@end
