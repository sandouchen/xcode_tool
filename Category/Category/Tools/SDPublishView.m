//
//  SDPublishView.m
//  Category
//
//  Created by fqq3 on 17/6/9.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDPublishView.h"
#import "SDNavigationController.h"
#import "SDPostWordViewController.h"

static const CGFloat SDSpringFactor = 7;

@interface SDPublishView ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *cancelButton;

/** 标语ImageView */
@property (nonatomic, weak) UIImageView *sloganImageView;
/** 记录按钮数组 */
@property (nonatomic, strong) NSMutableArray *buttons;
/** 动画时间 */
@property (nonatomic, strong) NSArray *times;
@end

@implementation SDPublishView
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.image = [UIImage imageNamed:@"shareBottomBackground"];
        
        [self addSubview:_backgroundImageView];
        
    }
    return _backgroundImageView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_cancelButton setBackgroundColor:[UIColor whiteColor]];
        [_cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_cancelButton addTarget:self action:@selector(cancel) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (void)cancel {
    [self cancelWithCompletionBlock:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    static const CGFloat buttonlayout = 40;
    
    self.backgroundImageView.frame = SDScreenB;
    
    self.cancelButton.frame = CGRectMake(0, self.sd_height - buttonlayout, self.sd_width, buttonlayout);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        // 禁止交互
        [self setWindowInteractionEnabled:NO];
        [self setupButton];
        [self setupsloganImageView];
    }
    return self;
}

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

- (void)setupsloganImageView {
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.sd_bottom = self.sd_top;
    sloganView.sd_centerX = SDScreenW * 0.5;
    [self insertSubview:sloganView aboveSubview:self.backgroundImageView];
    self.sloganImageView = sloganView;
    
    // 添加动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(SDScreenH * 0.2);
    anim.springSpeed = SDSpringFactor;
    anim.springBounciness = SDSpringFactor;
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    // 动画完成后开启交互
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [self setWindowInteractionEnabled:YES];
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
        [self insertSubview:button aboveSubview:self.backgroundImageView];
        [self.buttons addObject:button];
        
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button sd_setImagePosition:(SDImagePositionTop) spacing:SDLayoutMargin_10];
        [button sizeToFit];
        
        // 按钮尺寸
        CGFloat buttonW = SDScreenW / maxColsCount;
        CGFloat buttonH = button.sd_height + SDLayoutMargin_10;
        CGFloat buttonX = (i % maxColsCount) * buttonW;
        
        // 取出2个按钮的高度，在屏幕中点的位置
        CGFloat centerY = (SDScreenH - rowsCount * buttonH) * 0.5;
        CGFloat buttonY = centerY + (i / maxColsCount) * buttonH;
        
        button.sd_bottom = self.sd_top;
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
            UIViewController *rootVC = SDWindowRootVc;
            [rootVC presentViewController:nav animated:YES completion:nil];
        }
    }];
}

/**
 * 先执行退出动画, 动画完毕后执行completionBlock
 */
- (void)cancelWithCompletionBlock:(void (^)())completionBlock {
    // 禁止交互
    [self setWindowInteractionEnabled:NO];
    
    // 按钮执行退出动画
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *button = self.buttons[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.toValue = @(button.layer.position.y + SDScreenH);
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [button.layer pop_addAnimation:anim forKey:nil];
    }
    
    // 标题执行退出动画
    __weak __typeof(&*self) weakSelf = self;
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(self.sloganImageView.layer.position.y + SDScreenH);
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [weakSelf fadeOutWithTime:0.2f];
        
        [self setWindowInteractionEnabled:YES];
        
        // 执行传进来的completionBlock参数
        !completionBlock ? : completionBlock();
    }];
    [self.sloganImageView.layer pop_addAnimation:anim forKey:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self cancelWithCompletionBlock:nil];
}

- (void)setWindowInteractionEnabled:(BOOL)enabled {
    [UIApplication sharedApplication].keyWindow.rootViewController.view.userInteractionEnabled = enabled;
}

@end
