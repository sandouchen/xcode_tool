//
//  SDPublishViewController.m
//  Category
//
//  Created by fqq3 on 17/6/6.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDPublishViewController.h"
#import "SDNavigationController.h"
#import "SDPostWordViewController.h"

static const CGFloat SDSpringFactor = 7;

@interface SDPublishViewController ()
/** 标语ImageView */
@property (nonatomic, weak) UIImageView *sloganImageView;
/** 记录按钮数组 */
@property (nonatomic, strong) NSMutableArray *buttons;
/** 动画时间 */
@property (nonatomic, strong) NSArray *times;
@end

@implementation SDPublishViewController
- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSArray *)times {
    if (!_times) {
        CGFloat interval = 0.1f;
        
        _times = @[@(5 * interval),
                   @(4 * interval),
                   @(3 * interval),
                   @(2 * interval),
                   @(1 * interval),
                   @(0 * interval),
                   @(6 * interval)];
    }
    return _times;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 禁止交互
    self.view.userInteractionEnabled = NO;
    [self setupButton];
    [self setupsloganImageView];
}

- (void)setupsloganImageView {
    CGFloat sloganY = SCREENHEIGHT * 0.2;
    
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.sd_bottom = self.view.sd_top;
    sloganView.sd_centerX = SCREENWIDTH * 0.5;
    [self.view addSubview:sloganView];
    self.sloganImageView = sloganView;
    
    // 添加动画
    __weak __typeof(&*self) weakSelf = self;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(sloganY);
    anim.springSpeed = SDSpringFactor;
    anim.springBounciness = SDSpringFactor;
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    // 动画完成后开启交互
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        weakSelf.view.userInteractionEnabled = YES;
    }];
    [sloganView.layer pop_addAnimation:anim forKey:nil];
}

- (void)setupButton {
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 按钮数量
    NSUInteger  buttonCount = images.count;
    // 一行的列数
    NSUInteger maxColsCount = 3;
    // 行数
    NSUInteger rowsCount = (buttonCount + maxColsCount - 1) / maxColsCount;
    
    for (int i = 0; i < images.count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setTag:i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [self.buttons addObject:button];
        
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button sd_setImagePosition:(SDImagePositionTop) spacing:SDLayoutMargin_10];
        [button sizeToFit];
        
        // 按钮尺寸
        CGFloat buttonW = SCREENWIDTH / maxColsCount;
        CGFloat buttonH = button.sd_height + SDLayoutMargin_10;
        CGFloat buttonX = (i % maxColsCount) * buttonW;
        // 取出2个按钮的高度，在屏幕中点的位置
        CGFloat centerY = (SCREENHEIGHT - rowsCount * buttonH) * 0.5;
        CGFloat buttonY = centerY + (i / maxColsCount) * buttonH;
        
        button.sd_bottom = self.view.sd_top;
        CGFloat startY = button.sd_bottom;
        
        // 添加动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, startY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        anim.springSpeed = SDSpringFactor;
        anim.springBounciness = SDSpringFactor;
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [button pop_addAnimation:anim forKey:nil];
    }
}

- (void)buttonClick:(UIButton *)button {
    [self cancelWithCompletionBlock:^{
        if (button.tag == 2) {
            SDPostWordViewController *postWord = [[SDPostWordViewController alloc] init];
            SDNavigationController *nav = [[SDNavigationController alloc] initWithRootViewController:postWord];
            UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
            [rootVC presentViewController:nav animated:YES completion:nil];
        }
    }];
}

/**
 * 先执行退出动画, 动画完毕后执行completionBlock
 */
- (void)cancelWithCompletionBlock:(void (^)())completionBlock {
    // 禁止交互
    self.view.userInteractionEnabled = NO;
    
    // 按钮执行退出动画
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *button = self.buttons[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.toValue = @(button.layer.position.y + SCREENHEIGHT);
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [button.layer pop_addAnimation:anim forKey:nil];
    }
    
    // 标题执行退出动画
    __weak __typeof(&*self) weakSelf = self;
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(self.sloganImageView.layer.position.y + SCREENHEIGHT);
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
        
        // 执行传进来的completionBlock参数
        !completionBlock ? : completionBlock();
    }];
    [self.sloganImageView.layer pop_addAnimation:anim forKey:nil];
}

- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self cancelWithCompletionBlock:nil];
}

@end
