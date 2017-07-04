//
//  SDPostWordViewController.m
//  Category
//
//  Created by fqq3 on 17/5/22.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDPostWordViewController.h"
#import "SDTextView.h"
#import "SDAddTagToolbar.h"
#import "SDCollectionViewTest.h"

@interface SDPostWordViewController () <UITextViewDelegate>
@property (nonatomic, strong) SDTextView *textView;
@property (nonatomic, strong) SDAddTagToolbar *toolbar;
@end

@implementation SDPostWordViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self wr_setNavBarBarTintColor:[[UIColor yellowColor] colorWithAlphaComponent:0.9]];
    
    [self setupNav];
    [self setupTextView];
    [self setupToolbar];
}

- (void)setupToolbar {
    self.toolbar = [SDAddTagToolbar sd_viewFromXib];
    
    [self.view addSubview:self.toolbar];
    
    [self addNotificationCenter];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.toolbar.sd_width = self.view.sd_width;
    self.toolbar.sd_bottom = self.view.sd_bottom;
}

#pragma mark - 添加通知监听键盘弹出事件
- (void)addNotificationCenter {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - 监听键盘事件,底部工具条跟随键盘弹出或隐藏
- (void)keyboardWillChangeFrame:(NSNotification *)note {
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
//        self.toolbar.transform = CGAffineTransformMakeTranslation(0, frame.origin.y - SCREENHEIGHT);
        
        self.toolbar.sd_bottom = frame.origin.y;
    }];
}

- (void)setupNav {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
//    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)setupTextView {
    self.textView = [SDTextView textView];
    self.textView.frame = self.view.bounds;
    self.textView.delegate = self;
    self.textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:self.textView];
    
//    __weak __typeof(&*self) weakSelf = self;
//    
//    [self.textView addTextDidChangeHandler:^(SDTextView *textView) {
//        weakSelf.navigationItem.rightBarButtonItem.enabled = weakSelf.textView.hasText;
//    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post {
    SDCollectionViewTest *collectionVC = [[SDCollectionViewTest alloc] init];
    [self.navigationController pushViewController:collectionVC animated:YES];
}

@end
