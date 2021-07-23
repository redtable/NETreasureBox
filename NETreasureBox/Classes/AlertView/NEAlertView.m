//
//  NEAlertView.m
//  WallGrass
//
//  Created by WangSen on 2021/1/15.
//

#import "NEAlertView.h"

#define AlertLineColor RGBColor(0xCCCCCC)
#define AlertBaseTag 999999

@interface NEAlertAction : NSObject

@property (nonatomic, copy) NSString * message;
@property (nonatomic, copy) void(^actionBlock)(void);

@end

@implementation NEAlertAction

@end

@interface NEAlertView ()

@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UITextView * messageView;
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

- (void)addLinkMessage:(NSString *)link actionBlock:(void(^)(void))actionBlock {
    NEAlertAction * action = [[NEAlertAction alloc] init];
    action.message = link;
    action.actionBlock = actionBlock;
    [self.linkActions addObject:action];
}

- (void)addButtonMessage:(NSString *)link actionBlock:(void(^)(void))actionBlock {
    NEAlertAction * action = [[NEAlertAction alloc] init];
    action.message = link;
    action.actionBlock = actionBlock;
    [self.buttonActions addObject:action];
}

- (void)showInView:(UIView *)view {
    [self addSubview:self.containerView];
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(MIN(NEScreenCurrentWidth, 428.f) - 45.f * 2);
        make.center.equalTo(self);
    }];
    [self.containerView addSubview:self.titleLabel];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).offset(10.f);
        make.left.equalTo(self.containerView).offset(15.f);
        make.right.equalTo(self.containerView).offset(-15.f);
    }];
    
    UIView * topLine = [[UIView alloc] init];
    topLine.backgroundColor = AlertLineColor;
    [self.containerView addSubview:topLine];
    [topLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10.f);
        make.height.mas_equalTo(NEOnePx);
    }];
    
    [self.containerView addSubview:self.messageView];
    [self.messageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20.f);
        make.width.left.equalTo(self.titleLabel);
        make.height.mas_equalTo(MAXFLOAT);
    }];
    
    UIView * bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = AlertLineColor;
    [self.containerView addSubview:bottomLine];
    [bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.top.equalTo(self.messageView.mas_bottom).offset(10.f);
        make.height.mas_equalTo(NEOnePx);
    }];
    
    [self layoutIfNeeded];
    CGFloat buttonLeft = 0.f;
    CGFloat buttonWidth = self.containerView.width / self.buttonActions.count;
    for (NSInteger i = 0; i < self.buttonActions.count; i++) {
        NEAlertAction * action = [self.buttonActions objectOrNilAtIndex:i];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = AlertBaseTag + i;
        button.titleLabel.font = NEFontMedium(16);
        [button setTitle:action.message forState:UIControlStateNormal];
        [button setTitleColor:RGBColor(0x666666) forState:UIControlStateNormal];
        if (i == self.buttonActions.count - 1) {
            button.titleLabel.font = NEFontBold(16);
            [button setTitleColor:RGBColor(0x4D8AF5) forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:button];
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(buttonLeft);
            make.top.equalTo(self.messageView.mas_bottom).offset(10.f);
            make.width.mas_equalTo(buttonWidth);
            make.height.mas_equalTo(44.f);
            make.bottom.equalTo(self.containerView);
        }];
        buttonLeft += buttonWidth;
        if (i < self.buttonActions.count - 1) {
            UIView * centerLine = [[UIView alloc] init];
            centerLine.backgroundColor = AlertLineColor;
            [self.containerView addSubview:centerLine];
            [centerLine mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(button.mas_right).offset(-NEOnePx);
                make.top.height.equalTo(button);
                make.width.mas_equalTo(NEOnePx);
            }];
        }
    }
    
    self.titleLabel.text = self.title;
    NSMutableAttributedString * message = [[NSMutableAttributedString alloc] initWithString:self.message];
    [message addAttribute:NSFontAttributeName value:NEFontRegular(14) range:NSMakeRange(0, self.message.length)];
    [message addAttribute:NSForegroundColorAttributeName value:RGBColor(0x333333) range:NSMakeRange(0, self.message.length)];
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    style.minimumLineHeight = 16.f;
    style.maximumLineHeight = 16.f;
    style.lineSpacing = 2.f;
    style.firstLineHeadIndent = 28.f;
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
    [view addSubview:self];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
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
    if (action) {
        !action.actionBlock ?: action.actionBlock();
    }
    [self hide];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    NSString * host = URL.host;
    if (host.length) {
        NSInteger index = [host integerValue];
        NEAlertAction * action = [self.linkActions objectOrNilAtIndex:index];
        if (action) {
            !action.actionBlock ?: action.actionBlock();
        }
    }
    return NO;
}

#pragma mark - Getters -

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
