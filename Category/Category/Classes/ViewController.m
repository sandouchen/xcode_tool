//
//  ViewController.m
//  Category
//
//  Created by fqq3 on 17/2/23.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
#import "UIColor+SDExtend.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *cutView;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.imageView.image = [[UIImage imageNamed:@"RS3"] sd_imageWithTintColor:[UIColor orangeColor]];
    
//    self.imageView.image = [[UIImage imageNamed:@"RS3"] sd_imageWithGradientTintColor:[UIColor orangeColor]];
    
    self.imageView.image = [UIImage imageNamed:@"RS3"];
    
//    self.imageView.image = [UIImage sd_cutScreen];
    
    UIImage *image = [self.imageView.image sd_cutWithFrame:CGRectMake(0, 0, 100, 100)];
    
    [self.btn setBackgroundImage:image forState:(UIControlStateNormal)];
    [self.btn sizeToFit];
    self.cutView.sd_radius = 10;
    [self.cutView setBorder:[UIColor yellowColor] width:3];
    
//    self.btn.sd_top = self.imageView.sd_bottom + 5;
//    self.btn.sd_centerY = self.imageView.sd_centerY;
    self.btn.center = self.imageView.center;
    
    TestView *testView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TestView class]) owner:nil options:nil].lastObject;
    [self.view addSubview:testView];
    testView.frame = CGRectMake(50, 400, 90, 150);
    testView.backgroundColor = [UIColor sd_colorWithHexString:@"ff7f50"];
    testView.sd_top = self.imageView.sd_bottom + 10;
    testView.sd_size = self.imageView.sd_size;
    
    testView.sd_origin = CGPointMake(10, 10);
    
}
- (IBAction)click {
//    self.imageView.image = [UIImage sd_cutScreen];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
