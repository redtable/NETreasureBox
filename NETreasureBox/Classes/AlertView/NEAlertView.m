//
//  NEAlertView.m
//  WallGrass
//
//  Created by WangSen on 2021/1/15.
//

#import "NEAlertView.h"

#define AlertLineColor RGBColor(0xd9d9d9)
#define AlertBaseTag 999999

@interface NEAlertAction : NSObject

@property (nonatomic, copy) NSString * message;
@property (nonatomic, copy) void(^actionBlock)(void);
@property (nonatomic, copy) void(^textActionBlock)(NSString * text);

@end

@implementation NEAlertAction

@end

@interface NEAlertView ()

@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UITextView * messageView;
@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) NSMutableArray <NEAlertAction *>* textActions;
@property (nonatomic, strong) NSMutableArray <NEAlertAction *>* linkActions;
@property (nonatomic, strong) NSMutableArray <NEAlertAction *>* buttonActions;

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * message;

@end

@interface NEAlertView () <UITextViewDelegate>

@end

@implementation NEAlertView

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message {
    NEAlertView * alertView = [[NEAlertView alloc] init];
    alertView.backgroundColor = RGBAColor(0x000000, 0.3f);
    alertView.title = title;
    alertView.message = message;
    return alertView;
}

- (void)addTextFieldMessage:(NSString *)message actionBlock:(void(^)(NSString * text))actionBlock {
    NEAlertAction * action = [[NEAlertAction alloc] init];
    action.message = message;
    action.textActionBlock = actionBlock;
    [self.textActions addObject:action];
}

- (void)addLinkMessage:(NSString *)message actionBlock:(void(^)(void))actionBlock {
    NEAlertAction * action = [[NEAlertAction alloc] init];
    action.message = message;
    action.actionBlock = actionBlock;
    [self.linkActions addObject:action];
}

- (void)addButtonMessage:(NSString *)message actionBlock:(void(^)(void))actionBlock {
    NEAlertAction * action = [[NEAlertAction alloc] init];
    action.message = message;
    action.actionBlock = actionBlock;
    [self.buttonActions addObject:action];
}

- (void)showInView:(UIView *)view {
    [self addSubview:self.containerView];
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(MIN(NEScreenCurrentWidth, 428.f) - 80.f * 2);
        make.center.equalTo(self);
    }];
    MASViewAttribute * lastAttribute = self.containerView.mas_top;
    if ([self.title isNotBlank]) {
        [self.containerView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).offset(10.f);
            make.left.equalTo(self.containerView).offset(25.f);
            make.right.equalTo(self.containerView).offset(-25.f);
        }];
        UIView * topLine = [[UIView alloc] init];
        topLine.backgroundColor = AlertLineColor;
        [self.containerView addSubview:topLine];
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.containerView);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10.f);
            make.height.mas_equalTo(NEOnePx);
        }];
        lastAttribute = topLine.mas_bottom;
    }
    
    if ([self.message isNotBlank]) {
        [self.containerView addSubview:self.messageView];
        [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).offset(20.f);
            make.left.equalTo(self.containerView).offset(25.f);
            make.right.equalTo(self.containerView).offset(-25.f);
            make.height.mas_equalTo(MAXFLOAT);
        }];
        
        UIView * bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = AlertLineColor;
        [self.containerView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.containerView);
            make.top.equalTo(self.messageView.mas_bottom).offset(10.f);
            make.height.mas_equalTo(NEOnePx);
        }];
        lastAttribute = bottomLine.mas_bottom;
    }
    
    [self layoutIfNeeded];
    if (self.textActions.count) {
        NEAlertAction * action = self.textActions.firstObject;
        [self.containerView addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).offset(10.f);
            make.left.equalTo(self.containerView).offset(25.f);
            make.right.equalTo(self.containerView).offset(-25.f);
            make.height.mas_equalTo(30.f);
        }];
        self.textField.text = action.message;
        lastAttribute = self.textField.mas_bottom;
    }
    
    CGFloat buttonLeft = 0.f;
    CGFloat buttonWidth = self.containerView.width / self.buttonActions.count;
    for (NSInteger i = 0; i < self.buttonActions.count; i++) {
        NEAlertAction * action = [self.buttonActions objectOrNilAtIndex:i];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = AlertBaseTag + i;
        button.titleLabel.font = NEFontMedium(12);
        [button setTitle:action.message forState:UIControlStateNormal];
        [button setTitleColor:RGBColor(0x333333) forState:UIControlStateNormal];
        if (i == self.buttonActions.count - 1) {
            button.titleLabel.font = NEFontMedium(12);
            [button setTitleColor:RGBColor(0x333333) forState:UIControlStateNormal];
//            [button setTitleColor:RGBColor(0x4D8AF5) forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(buttonLeft);
            make.top.equalTo(lastAttribute);
            make.width.mas_equalTo(buttonWidth);
            make.height.mas_equalTo(39.f);
            make.bottom.equalTo(self.containerView);
        }];
        buttonLeft += buttonWidth;
        if (i < self.buttonActions.count - 1) {
            UIView * centerLine = [[UIView alloc] init];
            centerLine.backgroundColor = AlertLineColor;
            [self.containerView addSubview:centerLine];
            [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(button.mas_right).offset(-NEOnePx);
                make.top.height.equalTo(button);
                make.width.mas_equalTo(NEOnePx);
            }];
        }
    }
    
    self.titleLabel.text = self.title;
    
    if ([self.message isNotBlank]) {
        NSMutableAttributedString * message = [[NSMutableAttributedString alloc] initWithString:self.message];
        [message addAttribute:NSFontAttributeName value:NEFontRegular(12) range:NSMakeRange(0, self.message.length)];
        [message addAttribute:NSForegroundColorAttributeName value:RGBColor(0x03081a) range:NSMakeRange(0, self.message.length)];
        NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
        style.minimumLineHeight = 13.f;
        style.maximumLineHeight = 13.f;
        style.lineSpacing = 0.f;
        style.alignment = NSTextAlignmentCenter;
    //    style.firstLineHeadIndent = 28.f;
        [message addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.message.length)];
        for (NSInteger i = 0; i < self.linkActions.count; i++) {
            NEAlertAction * action = [self.linkActions objectOrNilAtIndex:i];
            NSRange range = [self.message rangeOfString:action.message];
            if (range.location != NSNotFound) {
                [message addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"xxx://%ld", i] range:range];
            }
        }
        self.messageView.attributedText = message;
        CGSize messageSize = [self.messageView sizeThatFits:self.messageView.size];
        [self.messageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(messageSize.height);
        }];
    }
    
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
}

- (void)hide {
    [self removeFromSuperview];
}

#pragma mark - Actions -

- (void)tapButtonAction:(UIButton *)button {
    NSInteger index = button.tag - AlertBaseTag;
    NEAlertAction * action = [self.buttonActions objectOrNilAtIndex:index];
    !action.actionBlock ?: action.actionBlock();
    if (self.textActions.count) {
        NEAlertAction * textAction = self.textActions.firstObject;
        !textAction.textActionBlock ?: textAction.textActionBlock(self.textField.text);
    }
    [self hide];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    NSString * host = URL.host;
    if (host.length) {
        NSInteger index = [host integerValue];
        NEAlertAction * action = [self.linkActions objectOrNilAtIndex:index];
        !action.actionBlock ?: action.actionBlock();
    }
    return NO;
}

#pragma mark - Getters -

- (NSMutableArray<NEAlertAction *> *)textActions {
    if (!_textActions) {
        _textActions = [NSMutableArray array];
    }
    return _textActions;
}

- (NSMutableArray<NEAlertAction *> *)linkActions {
    if (!_linkActions) {
        _linkActions = [NSMutableArray array];
    }
    return _linkActions;
}

- (NSMutableArray<NEAlertAction *> *)buttonActions {
    if (!_buttonActions) {
        _buttonActions = [NSMutableArray array];
    }
    return _buttonActions;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 10.f;
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.borderColor = AlertLineColor.CGColor;
        _containerView.layer.borderWidth = NEOnePx;
    }
    return _containerView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textColor = RGBColor(0x333333);
        _textField.font = NEFontRegular(14);
        _textField.layer.borderColor = AlertLineColor.CGColor;
        _textField.layer.borderWidth = NEOnePx;
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _textField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}

- (UITextView *)messageView {
    if (!_messageView) {
        _messageView = [[UITextView alloc] init];
        _messageView.editable = NO;
        _messageView.scrollEnabled = NO;
        _messageView.textContainer.lineFragmentPadding = 0;
        _messageView.textContainerInset = UIEdgeInsetsZero;
        _messageView.delegate = self;
    }
    return _messageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = NEFontBold(16);
        _titleLabel.textColor = RGBColor(0x333333);
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

@end
