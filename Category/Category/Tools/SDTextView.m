//
//  SDTextView.m
//  Category
//
//  Created by fqq3 on 17/5/22.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDTextView.h"

@interface SDTextView ()
/** 占位文字label */
@property (nonatomic, weak) UILabel *placeholderLabel;
/** 文本改变Block */
@property (nonatomic, copy) SDTextViewHandler changeHandler;
/** 达到最大限制字符数Block */
@property (nonatomic, copy) SDTextViewHandler maxHandler;

@end

@implementation SDTextView
#pragma mark - 懒加载placeholderLabel
- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.sd_left = 5;
        placeholderLabel.sd_top = 8;
        
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

#pragma mark - 初始化TextView
+ (instancetype)textView {
    return [[self alloc] init];
}

- (void)initialize {
    // 垂直方向上永远有弹簧效果
    self.alwaysBounceVertical = YES;
    // 滚动隐藏键盘
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    // 默认字体
    self.font = [UIFont systemFontOfSize:15];
    // 文字最大限制
    self.maxLength = NSUIntegerMax;
    // 自适应高度(默认为 NO)
    self.autoHeight = NO;
    // 自适应高度设置最小高度(自适应高度为 YES,该值必须大于0)
    self.minHeight = 0;
    // 默认的占位文字颜色
    self.placeholderColor = [UIColor colorWithRed:0.780 green:0.780 blue:0.804 alpha:1.000];
    // 监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark - 代码加载初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

#pragma mark - xib/storyboard加载初始化
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

#pragma mark - 监听文字改变
- (void)textDidChange {
    // 只要有文字, 就隐藏占位文字label
    self.placeholderLabel.hidden = self.hasText;
    
    // 禁止第一个字符输入空格或者换行
    if (self.text.length == 1) {
        if ([self.text isEqualToString:@" "] || [self.text isEqualToString:@"\n"]) {
            self.text = @"";
        }
    }
    
    // 只有当maxLength字段的值不为无穷大整型时才计算限制字符数
    if (self.maxLength != NSUIntegerMax) {
        NSString *toBeStr = self.text;
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        
        if (!position) {
            if (toBeStr.length > self.maxLength) {
                self.text = [toBeStr substringToIndex:self.maxLength];
                self.maxHandler ? self.maxHandler(self) : NULL;
            }
        }
    }
    
    [self updateTextViewHeight];
    
    self.changeHandler ? self.changeHandler(self) : NULL;
}

#pragma mark - UITextView自适应高度
- (void)updateTextViewHeight{
    if (!self.autoHeight || self.minHeight == 0) return;
    
    CGRect rect = self.frame;
    rect.size.height = self.contentSize.height;
    
    if (rect.size.height <= self.minHeight) return;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = rect;
    }];
    
    [self scrollRangeToVisible:NSMakeRange(0,0)];
}

/** 设定文本改变Block回调. (切记弱化引用, 以免造成内存泄露.) */
- (void)addTextDidChangeHandler:(SDTextViewHandler)changeHandler{
    _changeHandler = [changeHandler copy];
}

/** 设定达到最大长度Block回调. (切记弱化引用, 以免造成内存泄露.) */
- (void)addTextLengthDidMaxHandler:(SDTextViewHandler)maxHandler {
    _maxHandler = [maxHandler copy];
}

#pragma mark - 更新占位文字的尺寸
- (void)layoutSubviews {
    [super layoutSubviews];
    self.placeholderLabel.sd_width = self.sd_width - 2 * self.placeholderLabel.sd_left;
    [self.placeholderLabel sizeToFit];
}

#pragma mark - 重写setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self textDidChange];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.changeHandler = NULL;
    self.maxHandler = NULL;
}

@end
