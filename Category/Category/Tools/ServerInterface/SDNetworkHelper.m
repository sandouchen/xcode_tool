//
//  SDNetworkHelper.m
//  Category
//
//  Created by fqq3 on 17/4/12.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDNetworkHelper.h"


static NSMutableArray *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;

@implementation SDNetworkHelper
#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 *  initialize该初始化方法在当用到此类时候只调用一次
 */
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    
    // 设置服务器返回结果的类型:JSON
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 设置请求的超时时间
    _sessionManager.requestSerializer.timeoutInterval = 30.f;
    
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

#pragma mark - 重置AFHTTPSessionManager相关属性
+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    sessionManager ? sessionManager(_sessionManager) : nil;
}

+ (void)setRequestSerializer:(SDRequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = requestSerializer == SDRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(SDResponseSerializer)responseSerializer {
    _sessionManager.responseSerializer = responseSerializer == SDResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)openNetworkActivityIndicator:(BOOL)open {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

#pragma mark - 配置自建证书的Https请求
+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [_sessionManager setSecurityPolicy:securityPolicy];
}

#pragma mark - 开始监听网络
/** 开始监测网络状态 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (void)networkStatusWithBlock:(SDNetworkStatus)networkStatus {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown: // 未知网络
                    networkStatus ? networkStatus(SDNetworkStatusUnknown) : nil;
                    
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable: // 无网络
                    networkStatus ? networkStatus(SDNetworkStatusNotReachable) : nil;
                    
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWWAN: // 蜂窝网络
                    networkStatus ? networkStatus(SDNetworkStatusReachableViaWWAN) : nil;
                    
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                    networkStatus ? networkStatus(SDNetworkStatusReachableViaWiFi) : nil;
                    
                    break;
            }
        }];
    });
}

+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

+ (void)cancelAllRequest {
    // 锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
    
//    [_sessionManager invalidateSessionCancelingTasks:YES];
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) { return; }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - GET请求无缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                  success:(SDHttpRequestSuccess)success
                  failure:(SDHttpRequestFailed)failure {
    return [self GET:URL parameters:parameters responseCache:nil success:success failure:failure];
}

#pragma mark - POST请求无缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(SDHttpRequestSuccess)success
                   failure:(SDHttpRequestFailed)failure {
    return [self POST:URL parameters:parameters responseCache:nil success:success failure:failure];
}

#pragma mark - GET请求自动缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
            responseCache:(SDHttpRequestCache)responseCache
                  success:(SDHttpRequestSuccess)success
                  failure:(SDHttpRequestFailed)failure {
    // 读取缓存
    responseCache != nil ? responseCache([SDNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    NSURLSessionTask *sessionTask = [_sessionManager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self allSessionTask] removeObject:task];
        
        success ? success(responseObject) : nil;
        
        // 对数据进行异步缓存
        responseCache != nil ? [SDNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allSessionTask] removeObject:task];
        
        failure ? failure(error) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - POST请求自动缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
             responseCache:(SDHttpRequestCache)responseCache
                   success:(SDHttpRequestSuccess)success
                   failure:(SDHttpRequestFailed)failure {
    //读取缓存
    responseCache != nil ? responseCache([SDNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self allSessionTask] removeObject:task];
        
        success ? success(responseObject) : nil;
        
        // 对数据进行异步缓存
        responseCache != nil ? [SDNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allSessionTask] removeObject:task];
        
        failure ? failure(error) : nil;
    }];
    
    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 上传图片文件
+ (NSURLSessionTask *)uploadWithURL:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                             images:(NSArray<UIImage *> *)images
                               name:(NSString *)name
                           fileName:(NSString *)fileName
                           mimeType:(NSString *)mimeType
                           progress:(SDHttpProgress)progress
                            success:(SDHttpRequestSuccess)success
                            failure:(SDHttpRequestFailed)failure {
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 压缩-添加-上传图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:[NSString stringWithFormat:@"%@%lu.%@", fileName, (unsigned long)idx, mimeType ? mimeType : @"jpeg"]
                                    mimeType:[NSString stringWithFormat:@"image/%@", mimeType ? mimeType : @"jpeg"]];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self allSessionTask] removeObject:task];
        
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allSessionTask] removeObject:task];
        
        failure ? failure(error) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 上传文件
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:(SDHttpProgress)progress
                                success:(SDHttpRequestSuccess)success
                                failure:(SDHttpRequestFailed)failure {
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
        
        (failure && error) ? failure(error) : nil;
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self allSessionTask] removeObject:task];
        
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allSessionTask] removeObject:task];
        
        failure ? failure(error) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 上传多张图片
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(SDHttpProgress)progress
                                  success:(SDHttpRequestSuccess)success
                                  failure:(SDHttpRequestFailed)failure {
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            
            // 默认图片的文件名, 若fileNames为nil就使用
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = [NSString stringWithFormat:@"%@%zd.%@", str, i, imageType ?: @"jpg"];
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? [NSString stringWithFormat:@"%@.%@", fileNames[i], imageType ?: @"jpg"] : imageFileName
                                    mimeType:[NSString stringWithFormat:@"image/%@",imageType ?: @"jpg"] ];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self allSessionTask] removeObject:task];
        
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allSessionTask] removeObject:task];
        
        failure ? failure(error) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(SDHttpProgress)progress
                              success:(void(^)(NSString *))success
                              failure:(SDHttpRequestFailed)failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        
        // 打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // 创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        
        // 拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        // 返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[self allSessionTask] removeObject:downloadTask];
        
        if(failure && error) {failure(error) ; return ;};
        
        /** NSURL->NSString*/
        success ? success(filePath.absoluteString) : nil;
    }];
    
    // 开始下载
    [downloadTask resume];
    
    // 添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil ;
    
    return downloadTask;
}

/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

@end

#pragma mark - NSDictionary,NSArray的分类,控制台打印json数据中的中文
#ifdef DEBUG
@implementation NSDictionary (Log)
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}
@end

@implementation NSArray (Log)
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个[
    [string appendString:@"[\n"];
    
    // 遍历所有的元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [string appendFormat:@"\t%@,\n", obj];
    }];
    
    // 结尾有个]
    [string appendString:@"]"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}
@end
#endif
