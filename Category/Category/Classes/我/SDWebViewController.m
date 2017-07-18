//
//  SDWebViewController.m
//  Category
//
//  Created by fqq3 on 2017/7/7.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDWebViewController.h"

@interface SDWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@end

@implementation SDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark - 监听点击
- (IBAction)reload {
    [self.webView reload];
}

- (IBAction)back {
    [self.webView goBack];
}

- (IBAction)forward {
    [self.webView goForward];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
    
}

@end
