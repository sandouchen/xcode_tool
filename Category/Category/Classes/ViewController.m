//
//  ViewController.m
//  Category
//
//  Created by fqq3 on 17/2/23.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"

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
    
    UIView *testView = [UIView viewFromXib];
    [self.view addSubview:testView];
    testView.frame = CGRectMake(300, 50, 90, 150);
}
- (IBAction)click {
//    self.imageView.image = [UIImage sd_cutScreen];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
