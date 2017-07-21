//
//  SDShowPictureViewController.m
//  Category
//
//  Created by fqq3 on 17/4/26.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDShowPictureViewController.h"
#import "SDTopic.h"
#import <Photos/Photos.h>

@interface SDShowPictureViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet SDProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation SDShowPictureViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.userInteractionEnabled = YES;
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:self.imageView];
    
    CGFloat pictureW = SCREENWIDTH;
    CGFloat pictureH = pictureW * self.topics.height / self.topics.width;
    
    if (pictureH > SCREENHEIGHT) {
        self.imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
        self.imageView.sd_size = CGSizeMake(pictureW, pictureH);
        self.imageView.sd_centerY = SCREENHEIGHT * 0.5;
    }
    
    // 缩放比例
    CGFloat scale =  self.topics.width / self.imageView.sd_width;
    
    if (scale > 1.0) {
        self.scrollView.maximumZoomScale = scale;
    }
    
    [self.progressView setProgress:self.topics.pictureProgress animated:YES];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topics.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        // 图片下载失败
        if (image == nil) return;
        self.bottomView.hidden = NO;
    }];
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)forwarding {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"朋友圈" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"转发到朋友圈");
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"微信" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"转发到微信");
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"微博" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"转发到微博");
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击了[取消]按钮");
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusRestricted) {
        // 因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
        [SVProgressHUD showErrorWithStatus:@"因为系统原因, 无法访问相册"];
    } else if (status == PHAuthorizationStatusDenied) {
        // 用户拒绝当前应用访问相册(用户当初点击了"不允许")
        //直接跳转到 【设置-隐私-照片】
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:SDStringFormat(@"如需重新获取相册访问权可前往[设置-隐私-照片-%@]打开开关", APPNAME) preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            NSString *urlString = @"App-Prefs:root=Privacy&path=PHOTOS";
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
                if (SYSTEMVERSION >= 10.0) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                }
            }
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } else if (status == PHAuthorizationStatusAuthorized) {
        // 用户允许当前应用访问相册(用户当初点击了"好")
        [self saveImage];
        
    } else if (status == PHAuthorizationStatusNotDetermined) {
        // 用户还没有做出选择,弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                // 用户点击了好
                [self saveImage];
            }
        }];
    }
}

- (void)saveImage {
    // PHAsset的标识, 利用这个标识可以找到对应的PHAsset对象(图片对象)
    __block NSString *assetLocalIdentifier = nil;
    
    // 如果想对"相册"进行修改(增删改), 那么修改代码必须放在[PHPhotoLibrary sharedPhotoLibrary]的performChanges方法的block中
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 1.保存图片A到"相机胶卷"中
        // 创建图片的请求
        assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            [self showError:@"保存图片失败!"];
            return;
        }
        
        // 2.获得相簿
        PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
        
        if (createdAssetCollection == nil) {
            [self showError:@"创建相簿失败!"];
            return;
        }
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            // 3.添加"相机胶卷"中的图片A到"相簿"D中
            
            // 获得图片
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
            
            // 添加图片到相簿中的请求
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
            
            // 添加图片到相簿
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success == NO) {
                [self showError:@"保存图片失败!"];;
            } else {
                [self showSuccess:@"保存图片成功!"];;
            }
        }];
    }];
}

/**
 *  获得相簿
 */
- (PHAssetCollection *)createdAssetCollection {
    // 从已存在相簿中查找这个应用对应的相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:APPNAME]) {
            return assetCollection;
        }
    }
    
    // 没有找到对应的相簿, 得创建新的相簿
    
    // 错误信息
    NSError *error = nil;
    
    // PHAssetCollection的标识, 利用这个标识可以找到对应的PHAssetCollection对象(相簿对象)
    __block NSString *assetCollectionLocalIdentifier = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 创建相簿的请求
        assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:APPNAME].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    // 如果有错误信息
    if (error) return nil;
    
    // 获得刚才创建的相簿
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
}

- (IBAction)writeComment {
    ALERTVIEW(@"comming son");
}

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView*)scrollView {
    CGFloat centerX = scrollView.sd_centerX;
    CGFloat centerY = scrollView.sd_centerY;
    
    centerX = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width / 2 : centerX;
    
    centerY = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height / 2 : centerY;
    
    [self.imageView setCenter:CGPointMake(centerX, centerY)];
}

- (void)showSuccess:(NSString *)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:text];
    });
}

- (void)showError:(NSString *)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:text];
    });
}
@end
