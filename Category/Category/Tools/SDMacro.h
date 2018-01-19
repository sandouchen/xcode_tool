//
//  SDMacro.h
//  SD_Notes
//
//  Created by fqq3 on 16/7/28.
//  Copyright © 2016年 sandouchan. All rights reserved.
//  常用宏定义

#ifndef SDMacro_h
#define SDMacro_h

#pragma mark - 项目宏
// 导航栏背景颜色
#define NavBarBarTintColor [[UIColor yellowColor] colorWithAlphaComponent:0.9]


#pragma mark - 通用宏
// 由角度转换弧度 由弧度转换角度
#define SDDegreesToRadian(ANGLE) (M_PI * (ANGLE) / 180.0)
#define SDRadianToDegrees(radian) (radian * 180.0)/(M_PI)

// 读取本地图片
#define SDLoadImage(file, ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@#file ofType:@#ext]]

// 将服务器返回的数据写入plist
#define SDWriteToPlist(data, filename) [data writeToFile:[NSString stringWithFormat:@"/Users/fqq3/Desktop/%@.plist", @#filename] atomically:YES]

#define SDUserDefaults [NSUserDefaults standardUserDefaults]
#define SDNotificationCenter [NSNotificationCenter defaultCenter]
#define SDFileManager [NSFileManager defaultManager]

// 提示框
#define SDAlertView(_S_, ...) [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]


/*************** 打印宏 ***************/
// 调试状态判断
#ifdef DEBUG
#define SDLog(format, ...) printf("[%s] %s [第%zd行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#else
#define SDLog(format, ...)
#endif

#define SDLogFunc SDLog(@"---")
#define SDLogRect(rect) SDLog(@"%s = { x:%.f, y:%.f, w:%.f, h:%.f }", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
/*************** 打印宏 ***************/


/*************** 屏幕信息 ***************/
// 获取主屏幕
#define SDKeyWindow [UIApplication sharedApplication].keyWindow

// 获取主屏幕控制器
#define SDWindowRootVc SDKeyWindow.rootViewController

// 屏幕宽度
#define SDScreenW ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SDScreenH ([UIScreen mainScreen].bounds.size.height)

// 屏幕尺寸
#define SDScreenB [UIScreen mainScreen].bounds

#define iphone6P (SDScreenH == 736)
#define iphone6 (SDScreenH == 667)
#define iphone5 (SDScreenH == 568)
#define iphone4 (SDScreenH == 480)
/*************** 屏幕信息 ***************/


/*************** 系统信息 ***************/
// 获取系统版本
#define SDSystemVer [[[UIDevice currentDevice] systemVersion] doubleValue]

// 获取当前版本号
#define SDCurrentVer [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]

// 获取程序名称
#define SDAppName [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"]

// 获取程序图标图片
#define SDAppIconImage [UIImage imageNamed:[[[NSBundle mainBundle].infoDictionary valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject]]
/*************** 系统信息 ***************/


/*************** 路径信息 ***************/
// 获取沙盒 Document
#define SDDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

// 获取沙盒 Cache
#define SDCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
/*************** 路径信息 ***************/


/*************** 颜色宏 ***************/
// 自定义颜色
#define SDRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define SDRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// 随机色
#define RANDOMCOLOR SDRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((0x##rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(0x##rgbValue & 0xFF))/255.0 alpha:1.0]

#define HEXACOLOR(rgbValue, a) [UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((0x##rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(0x##rgbValue & 0xFF))/255.0 alpha:(a)]
/*************** 颜色宏 ***************/


/*************** 单例宏 ***************/
// 1.h头文件中的单例宏
#define singletonInterface(className) \
+ (instancetype)shared##className;

// 2.m文件中的单例宏
#if __has_feature(objc_arc) // ARC 部分

#define singletonImplementation(className) \
static id _instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
+ (instancetype)shared##className { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
    return _instance; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone { \
    return _instance; \
}

#else // MRC 部分

#define singletonImplementation(className) \
static id _instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
+ (instancetype)shared##className { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
    return _instance; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone { \
    return _instance; \
} \
- (oneway void)release {} \
- (instancetype)retain {return self;} \
- (instancetype)autorelease {return self;} \
- (NSUInteger)retainCount {return NSUIntegerMax;}
#endif
/*************** 单例宏 ***************/


#endif /* SDMacro_h */
