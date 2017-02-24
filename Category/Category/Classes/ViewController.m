//
//  ViewController.m
//  Category
//
//  Created by fqq3 on 17/2/23.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.imageView.image = [[UIImage imageNamed:@"RS3"] sd_imageWithTintColor:[UIColor orangeColor]];
    
//    self.imageView.image = [[UIImage imageNamed:@"RS3"] sd_imageWithGradientTintColor:[UIColor orangeColor]];
    
    self.imageView.image = [UIImage sd_imageWithColor:[UIColor redColor] size:CGSizeMake(100, 100)];
    
    
}


@end
