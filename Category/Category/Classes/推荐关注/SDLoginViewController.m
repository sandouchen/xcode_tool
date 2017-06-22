//
//  SDLoginViewController.m
//  Category
//
//  Created by fqq3 on 17/6/13.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDLoginViewController.h"

@interface SDLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *weiboBtn;
@property (weak, nonatomic) IBOutlet UIButton *tencentBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightMargin;

@end

@implementation SDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupQuickloginButton];
}

- (void)setupQuickloginButton {
    [self.weiboBtn sd_setImagePosition:(SDImagePositionTop) spacing:SDLayoutMargin_5];
    [self.qqBtn sd_setImagePosition:(SDImagePositionTop) spacing:SDLayoutMargin_5];
    [self.tencentBtn sd_setImagePosition:(SDImagePositionTop) spacing:SDLayoutMargin_5];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)loginClick {
    NSLog(@"登录");
}

- (IBAction)registeredAccount:(UIButton *)button {
    [self.view endEditing:YES];
    
    if (self.rightMargin.constant) {
        self.rightMargin.constant = 0;
        button.selected = NO;
    } else {
        self.rightMargin.constant = self.view.sd_width;
        button.selected = YES;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registeredClick {
    NSLog(@"注册");
}

- (IBAction)forgotPassword {
    NSLog(@"忘记密码");
}

- (IBAction)quicklogin:(UIButton *)sender {
    if (sender == self.tencentBtn) {
        NSLog(@"腾讯");
    } else if (sender == self.weiboBtn) {
        NSLog(@"微博");
    } else {
        NSLog(@"QQ");
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

@end
