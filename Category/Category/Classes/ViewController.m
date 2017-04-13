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
    
    
    
}

- (void)createUI {
    self.imageView.image = [[UIImage imageNamed:@"RS3"] sd_imageWithRoundedCornersAndSize:_imageView.sd_size andCornerRadius:_imageView.sd_width / 2];
    
    [_btn sd_setImagePosition:(SDImagePositionTop) spacing:5];
    
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
    
    NSString *image = @"friendsRecommentIcon";
    NSString *hImage = @"friendsRecommentIcon-click";
    NSString *title = @"Hello World";
    
    UIButton *btn = [UIButton sd_buttonWithImage:image highlImage:hImage title:title titleColor:[UIColor redColor] font:0 frame:CGRectMake(20, 200, 0, 0) sizeToFit:NO target:nil action:nil];
    btn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    [btn sd_setImagePosition:(SDImagePositionTop) spacing:5];
    [btn sizeToFit];
    
    
    UILabel *l = [UILabel sd_labelWithFrame:CGRectMake(20, 600, 0, 0) title:@"24小时未领完，将退回" font:20 color:[UIColor blackColor] alignment:(NSTextAlignmentLeft)];
    [l sizeToFit];
    [self.view addSubview:l];
    
    UIButton *b = [UIButton sd_buttonWithTitle:@"余额" titleColor:[UIColor redColor] font:20 BackgroundColor:nil frame:CGRectZero sizeToFit:NO target:self action:@selector(click)];
    [b sizeToFit];
    b.sd_left = l.sd_right;
    b.sd_centerY = l.sd_centerY;
    b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:b];
    
    UILabel *ll = [UILabel sd_labelWithFrame:CGRectZero title:@"请留意" font:20 color:[UIColor blackColor] alignment:(NSTextAlignmentLeft)];
    [ll sizeToFit];
    ll.sd_left = b.sd_right;
    ll.sd_centerY = b.sd_centerY;
    [self.view addSubview:ll];
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
