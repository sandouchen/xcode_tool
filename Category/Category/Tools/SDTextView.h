//
//  SDTextView.h
//  Category
//
//  Created by fqq3 on 17/5/22.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDTextView;

typedef void(^SDTextViewHandler)(SDTextView *textView);

@interface SDTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) IBInspectable NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;
/** 最大限制文本长度, 默认为无穷大(即不限制) */
@property (nonatomic, assign) IBInspectable NSUInteger maxLength;
/** 自适应高度(默认为 NO) */
@property (assign, nonatomic, getter=isAutoHeight) IBInspectable BOOL autoHeight;
/** 最小高度(自适应高度为YES时,该值必须设置) */
@property (nonatomic, assign) IBInspectable CGFloat minHeight; // 有问题~待修改

/** 初始化 */
+ (instancetype)textView;

/** 设定文本改变Block回调. (切记弱化引用, 以免造成内存泄露.) */
- (void)addTextDidChangeHandler:(SDTextViewHandler)eventHandler;

/** 设定达到最大长度Block回调. (切记弱化引用, 以免造成内存泄露.) */
- (void)addTextLengthDidMaxHandler:(SDTextViewHandler)maxHandler;
@end
