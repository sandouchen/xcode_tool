//
//  SDMeFooterView.m
//  Category
//
//  Created by fqq3 on 17/5/18.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDMeFooterView.h"
#import "SDSquare.h"
#import "SDSqaureButton.h"
#import "SDWebViewController.h"
#import <SafariServices/SafariServices.h>
#import "WKWebViewController.h"

@implementation SDMeFooterView
- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    // 发送请求
    [SDNetworkHelper GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(id responseObject) {
        NSArray *sqaures = [SDSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        // 创建方块
        [self createSquares:sqaures];
        
    } failure:^(NSError *error) {
        SDLog(@"error = %zd", (long)error.code);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/**
 * 创建方块
 */
- (void)createSquares:(NSArray *)sqaures
{
    // 一行最多4列
    NSUInteger maxCols = 4;
    
    // 宽度和高度
    CGFloat buttonW = self.sd_width / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < sqaures.count; i++) {
        // 创建按钮
        SDSqaureButton *button = [SDSqaureButton buttonWithType:(UIButtonTypeCustom)];
        
        // 监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 传递模型
        [self addSubview:button];
        
        // 计算frame
        CGFloat buttonX = (i % maxCols) * buttonW;
        CGFloat buttonY = (i / maxCols) * buttonH;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        button.square = sqaures[i];
    }
    
    // 设置footer的高度 == 最后一个按钮的bottom(最大Y值)
    self.sd_height = self.subviews.lastObject.sd_bottom;
    
    // 设置tableView的contentSize
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    // 重新刷新数据(会重新计算contentSize)
    [tableView reloadData];
}

- (void)buttonClick:(SDSqaureButton *)button {
    NSString *url = button.square.url;
    
    if ([url hasPrefix:@"http"]) {
        // wkWebView 浏览器
        WKWebViewController *wkWebView = [[WKWebViewController alloc] init];
        wkWebView.url = url;
        wkWebView.title = button.currentTitle;
        [self.currentViewController.navigationController pushViewController:wkWebView animated:YES];
        
        /*
        // webView 浏览器
        UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
        
        UINavigationController *navVC = tabBarVC.selectedViewController;
        
        SDWebViewController *webView = [[SDWebViewController alloc] init];
        webView.url = url;
        webView.navigationItem.title = button.currentTitle;
        [navVC pushViewController:webView animated:YES];
        */
        
        /*
        // safari 浏览器
        SFSafariViewController *webView = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
        
        // safari 控件颜色
        webView.preferredBarTintColor = NavBarBarTintColor;
        // safari 按钮颜色
        webView.preferredControlTintColor = [UIColor blackColor];
        
        UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
        
        [tabBarVC presentViewController:webView animated:YES completion:nil];
        */
        
    } else if ([url hasPrefix:@"mod"]) {
        SDLog(@"%@ 跳转到mod", button.currentTitle);
    } else {
        SDLog(@"%@ 不知道做什么", button.currentTitle);
    }
}










@end
