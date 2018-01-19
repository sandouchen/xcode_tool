//
//  SDAddTagViewController.m
//  Category
//
//  Created by fqq3 on 17/5/24.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDAddTagViewController.h"
#import "SDTagTextField.h"

@interface SDAddTagViewController () <UITextFieldDelegate>
@property (nonatomic, strong) SDTagTextField *textField;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIView *contentView;
/** 所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;
@property (nonatomic, strong) UIButton *tagButton;
@end

@implementation SDAddTagViewController
- (NSMutableArray *)tagButtons {
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        UIButton *addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        addBtn.sd_width = self.contentView.sd_width;
        addBtn.sd_height = self.textField.sd_height;
        [addBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addBtn.contentEdgeInsets = UIEdgeInsetsMake(0, SDLayoutMargin_5, 0, SDLayoutMargin_5);
        addBtn.backgroundColor = SDRGB(74, 139, 209);
        [addBtn addTarget:self action:@selector(addButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:addBtn];
        
        _addBtn = addBtn;
    }
    return _addBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupContentView];
    [self setupTextField];
    [self setupTags];
}

- (void)setupTags {
    for (NSString *tags in self.tags) {
        self.textField.text = tags;
        [self addButtonClick];
    }
}

- (void)setupContentView {
    self.contentView = [[UIView alloc] init];
    self.contentView.sd_top = SDNavigationBarH + SDLayoutMargin_5;
    self.contentView.sd_left = SDLayoutMargin_5;
    self.contentView.sd_width = self.view.sd_width - 2 * SDLayoutMargin_5;
    self.contentView.sd_height = self.view.sd_height - (SDNavigationBarH + 2 * SDLayoutMargin_5);
    [self.view addSubview:self.contentView];
}

- (void)setupTextField {
    self.textField = [[SDTagTextField alloc] init];
    self.textField.delegate = self;
    self.textField.sd_width = self.contentView.sd_width;
    self.textField.sd_height = 25;
    
    __weak __typeof(&*self) weakSelf = self;
    
    self.textField.deleteBlock = ^{
        if (weakSelf.textField.hasText) return;
        
        [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
    };
    
    [self.textField addTarget:self action:@selector(textDidChange) forControlEvents:(UIControlEventEditingChanged)];
    [self.contentView addSubview:self.textField];
}

- (void)textDidChange {
    [self updateTextFieldFrame];
    
    if (self.textField.hasText) {
        self.addBtn.hidden = NO;
        self.addBtn.sd_top = self.textField.sd_bottom + SDLayoutMargin_5;
        [self.addBtn setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:(UIControlStateNormal)];
        
        // 获得最后一个字符
        NSString *text = self.textField.text;
        NSUInteger len = text.length;
        NSString *lastLetter = [text substringFromIndex:len - 1];
        
        // 限制字数
        UITextRange *selectedRange = [self.textField markedTextRange];
        UITextPosition *position = [self.textField positionFromPosition:selectedRange.start offset:0];
        
        static const NSInteger maxLength = 20;
        
        if (!position) {
            if (len > maxLength) {
                [MBProgressHUD showError:NSLocalizedString(@"最多只能输10个字符", nil) toView:nil];
            }
        }
        
        // 按逗号确定
        if (([lastLetter isEqualToString:@","]
            || [lastLetter isEqualToString:@"，"]) && len > 1) {
            // 去除逗号
            self.textField.text = [text substringToIndex:len - 1];
            [self addButtonClick];
        }
    } else {
        self.addBtn.hidden = YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}

- (void)addButtonClick {
    _tagButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_tagButton setTitle:self.textField.text forState:(UIControlStateNormal)];
    [_tagButton setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    _tagButton.backgroundColor = SDRGB(74, 139, 209);
    _tagButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_tagButton sd_setImagePosition:(SDImagePositionRight) spacing:5];
    [_tagButton sizeToFit];
    _tagButton.sd_height = self.textField.sd_height;
    _tagButton.sd_radius = 8;
    [self.contentView addSubview:self.tagButton];
    [self.tagButtons addObject:self.tagButton];
    
    self.textField.text = nil;
    self.addBtn.hidden = YES;
    
    if (self.tagButtons.count == 5) {
        self.textField.hidden = YES;
        [self.view endEditing:YES];
    }
        
    
    // 更新标签按钮的frame
    [self updateTagButtonFrame];
    [self updateTextFieldFrame];
}

- (void)updateTagButtonFrame {
    for (int i = 0; i < self.tagButtons.count; i++) {
        UIButton *tagButton = self.tagButtons[i];
        
        if (i == 0) {
            tagButton.sd_left = 0;
            tagButton.sd_top = 0;
        } else {
            UIButton *lastTagButton = self.tagButtons[i - 1];
            
            CGFloat leftWidth = lastTagButton.sd_right + SDLayoutMargin_5;
            CGFloat rightWidth = self.contentView.sd_width - leftWidth;
            
            if (rightWidth > tagButton.sd_width) {
                tagButton.sd_top = lastTagButton.sd_top;
                tagButton.sd_left = leftWidth;
            } else {
                tagButton.sd_left = 0;
                tagButton.sd_top = lastTagButton.sd_bottom + SDLayoutMargin_5;
            }
        }
    }
}

- (void)updateTextFieldFrame {
    UIButton *lastTagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = lastTagButton.sd_right + SDLayoutMargin_5;
    
    if (self.contentView.sd_width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.sd_left = leftWidth;
        self.textField.sd_top = lastTagButton.sd_top;
    } else {
        self.textField.sd_left = 0;
        self.textField.sd_top = lastTagButton.sd_bottom + SDLayoutMargin_5;
    }
}

/**
 * textField的文字宽度
 */
- (CGFloat)textFieldTextWidth {
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    CGFloat minW = [self.textField.placeholder sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width - 10;
    
    return MAX(minW, textW);
}

- (void)tagButtonClick:(UIButton *)tagButton {
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    self.textField.hidden = NO;
    [self.textField becomeFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
}

- (void)setupNav {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)done {
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagBlock ? :self.tagBlock(tags);
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
