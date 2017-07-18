//
//  SDClearCacheCell.m
//  Category
//
//  Created by fqq3 on 2017/7/7.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDClearCacheCell.h"

#define SDCustomCacheFile [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"FQQ"]

static NSString *const clearCacheStr = @"缓存已清除";

@implementation SDClearCacheCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    // 设置cell右边的指示器
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    [loadingView startAnimating];
    self.accessoryView = loadingView;
    
    self.textLabel.text = @"正在计算缓存大小...";
    
    self.userInteractionEnabled = NO;
    
    __weak __typeof(&*self) weakSelf = self;
    
    // 在子线程计算缓存大小
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1.0];
        
        // 获得缓存文件夹路径
        unsigned long long size = SDCustomCacheFile.fileSize;
        size += [SDImageCache sharedImageCache].getSize;
        
        // 如果cell已经销毁了, 就直接返回
        if (weakSelf == nil) return;
        
        NSString *sizeText = nil;
        
        if (size >= pow(10, 9)) {
            sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            
        } else if (size >= pow(10, 6)) {
            sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            
        } else if (size >= pow(10, 3)) {
            sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            
        } else {
            sizeText = [NSString stringWithFormat:@"%zdB", size];
        }
        
        // 生成文字
        NSString *text = nil;
        
        if ([sizeText isEqualToString:@"0B"]) {
            text = clearCacheStr;
        } else {
            text = [NSString stringWithFormat:@"清除缓存(%@)", sizeText];
        }
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            // 设置文字
            weakSelf.textLabel.text = text;
            // 清空右边的指示器
            weakSelf.accessoryView = nil;
            // 显示右边的箭头
            weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            // 添加手势监听器
            [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clearCache)]];
            
            // 恢复点击事件
            weakSelf.userInteractionEnabled = YES;
        });
    });
}

#pragma mark - 清除缓存
- (void)clearCache{
    // 弹出指示器
    [SVProgressHUD showWithStatus:@"清除缓存..." ];
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeClear)];
    
    // 删除SDWebImage的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        // 删除自定义的缓存
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSFileManager *mgr = [NSFileManager defaultManager];
            
            [mgr removeItemAtPath:SDCustomCacheFile error:nil];
            [mgr createDirectoryAtPath:SDCustomCacheFile withIntermediateDirectories:YES attributes:nil error:nil];
            
            // 所有的缓存都清除完毕
            dispatch_async(dispatch_get_main_queue(), ^{
                [NSThread sleepForTimeInterval:1.0];
                
                // 隐藏指示器
                [SVProgressHUD showSuccessWithStatus:clearCacheStr];
                [SVProgressHUD dismissWithDelay:1.0];
                
                // 设置文字
                self.textLabel.text = clearCacheStr;
            });
        });
    }];
}

/**
 *  当cell重新显示到屏幕上时, 也会调用一次layoutSubviews
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // cell重新显示的时候, 继续转圈圈
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}

@end
