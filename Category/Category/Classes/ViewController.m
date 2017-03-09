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
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = [[UIImage imageNamed:@"RS3"] sd_imageWithRoundedCornersAndSize:_imageView.sd_size andCornerRadius:_imageView.sd_width / 2];
    
    
    [self.btn sizeToFit];
    [_btn sd_setImagePosition:(SDImagePositionBottom) spacing:5];
    
    
    
    UILabel *label = [UILabel sd_labelWithFrame:CGRectMake(20, 100, 100, 0) title:nil font:15 color:[UIColor redColor] alignment:(NSTextAlignmentCenter)];
    [label sizeToFit];
    label.backgroundColor = [UIColor greenColor];
    [self.view addSubview:label];
    
    [UILabel sd_delLineLabel:label withColor:label.textColor];
    [UILabel sd_underlineLabel:label withColor:[UIColor blueColor]];
    [UILabel sd_labelWordSpaceWithLabel:label WordSpace:20];
    [UILabel sd_labelLineSpaceWithLabel:label LineSpace:20];
    [UILabel sd_labelSpaceWithLabel:label lineSpace:20 wordSpace:20];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem sd_itemWithTitle:@"首页" titleColor:[UIColor greenColor] Target:nil action:nil image:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" insets:ContentInstesLeft];
    
    [UIBarButtonItem sd_itemWithTarget:self action:@selector(click) image:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" insets:ContentInstesLeft];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem sd_itemWithTitle:@"设置" titleColor:[UIColor blueColor] Target:nil action:nil image:@"nav_coin_icon" highImage:@"nav_coin_icon_click" insets:(ContentInstesRight)];
    
    [UIBarButtonItem sd_itemWithTarget:self action:nil image:@"mine-setting-icon" highImage:@"mine-setting-icon-click" insets:ContentInstesRight];
    
    
}
- (IBAction)click {
    TestView *testView = [TestView sd_viewFromXib];
    [self.view addSubview:testView];
    testView.frame = [UIScreen mainScreen].bounds;
    testView.backgroundColor = [HEXCOLOR(0b1746) colorWithAlphaComponent:.3];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
