//
//  SDMacro.h
//  SD_Notes
//
//  Created by fqq3 on 16/7/28.
//  Copyright © 2016年 sandouchan. All rights reserved.
//  常用宏定义

#ifndef SDMacro_h
#define SDMacro_h

// 获取主屏幕
#define KEYWINDOW [UIApplication sharedApplication].keyWindow

// 屏幕宽度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

// 屏幕高度
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

// 屏幕尺寸
#define SCREENBOUNDS [UIScreen mainScreen].bounds

// 获取系统版本
#define SYSTEMVERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// 获取当前版本号
#define CURRENTVERSION [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]

// 获取程序名称
#define APPNAME [NSBundle mainBundle].infoDictionary[@"CFBundleName"]

// 获取程序图标图片
#define APPICONIMAGE [UIImage imageNamed:[[[NSBundle mainBundle].infoDictionary valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject]]

// 获取沙盒 Document
#define DOCUMENTPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

// 获取沙盒 Cache
#define CACHEPATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// 由角度转换弧度 由弧度转换角度
#define ANGLETORADIAN(ANGLE) (M_PI * (ANGLE) / 180.0)
#define RADIANTOANGLE(radian) (radian * 180.0)/(M_PI)

// 读取本地图片
#define LOADIMAGE(file, ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@#file ofType:@#ext]]

// 定义UIImage对象
#define IMAGENAME(imageName) [UIImage imageNamed:@#imageName]

// 转换字符串
#define SDStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

// 自定义颜色
#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((0x##rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(0x##rgbValue & 0xFF))/255.0 alpha:1.0]

#define HEXACOLOR(rgbValue, a) [UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((0x##rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(0x##rgbValue & 0xFF))/255.0 alpha:(a)]

// 随机色
#define RANDOMCOLOR RGBCOLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


// NSUserDefaults
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]
#define USERDEFAULTSSYN [[NSUserDefaults standardUserDefaults] synchronize]

// 使用__weak避免循环保留
#define WeakSelf(weakSelf) __weak __typeof(&*self) weakSelf = self;
#define StrongSelf(strongSelf) __strong __typeof(&*self) strongSelf = weakSelf;

#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type)  __strong typeof(type) type = weak##type;

// View 圆角和加边框
#define VIEWBORDERRADIUS(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define VIEWRADIUS(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// View 坐标(x,y)和宽高(width,height)
#define FRAMEX(v)   (v).frame.origin.x
#define FRAMEY(v)   (v).frame.origin.y

#define WIDTH(v)    (v).frame.size.width
#define HEIGHT(v)   (v).frame.size.height

#define MinX(v)     CGRectGetMinX((v).frame)
#define MinY(v)     CGRectGetMinY((v).frame)

#define MidX(v)     CGRectGetMidX((v).frame)
#define MidY(v)     CGRectGetMidY((v).frame)

#define MaxX(v)     CGRectGetMaxX((v).frame)
#define MaxY(v)     CGRectGetMaxY((v).frame)


// 提示框
#define ALERTVIEW(_S_, ...) [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

// 调试状态判断
/*
 #ifndef __OPTIMIZE__
 #define NSLog(...) NSLog(__VA_ARGS__)
 #else
 #define NSLog(...) {}
 #endif
 */

#ifdef DEBUG
#define NSLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

// 打印rect,size,point
#ifdef DEBUG
#define LOGPOINT(point)    NSLog(@"%s = { x:%.f, y:%.f }", #point, point.x, point.y)
#define LOGSIZE(size)      NSLog(@"%s = { w:%.f, h:%.f }", #size, size.width, size.height)
#define LOGRECT(rect)      NSLog(@"%s = { x:%.f, y:%.f, w:%.f, h:%.f }", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#endif

// 单例宏
// 1. 解决.h文件
#define singletonInterface(className) + (instancetype)shared##className;
// 2. 解决.m文件
// 判断 是否是 ARC
#if __has_feature(objc_arc)
#define singletonImplementation(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return instance; \
}
#else
// MRC 部分
#define singletonImplementation(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
return instance; \
} \
+ (instancetype)shared##className { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return instance; \
} \
- (oneway void)release {} \
- (instancetype)retain {return instance;} \
- (instancetype)autorelease {return instance;} \
- (NSUInteger)retainCount {return ULONG_MAX;}
#endif

#endif /* SDMacro_h */
