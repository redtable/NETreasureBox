//
//  NEPlaceholderView.m
//  WallGrass
//
//  Created by WangSen on 2020/12/8.
//

#import "NEPlaceholderView.h"

#define kLimitWidth (NEScreenCurrentWidth - 60.f * 2)

@interface NEPlaceholderView ()

@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * textLabel;
@property (nonatomic, strong) UIButton * retryButton;
@property (nonatomic, copy) void (^retryHandler)(void);

@end

@implementation NEPlaceholderView

- (instancetype)initWithImage:(UIImage *)image prompt:(NSString *)prompt {
    if (self = [super init]) {
        _image = image;
        _prompt = [prompt copy];
        self.backgroundColor = [UIColor whiteColor];
        [self createViewHierarchy];
        [self layoutContentViews];
    }
    return self;
}

- (void)createViewHierarchy {
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.imageView];
    [self.containerView addSubview:self.textLabel];
}

- (void)layoutContentViews {
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-50.f);
        make.width.mas_equalTo(kLimitWidth);
    }];
    
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView.mas_centerX);
        make.top.equalTo(self.containerView.mas_top);
//        make.size.mas_equalTo(CGSizeMake(102.f, 102.f));
        make.size.mas_equalTo(CGSizeMake(219.f, 246.f));
    }];
    
    BOOL hasRetryButton = _retryButton.superview;
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(24.f);
        make.centerX.equalTo(self.containerView.mas_centerX);
        make.width.mas_lessThanOrEqualTo(kLimitWidth);
        if (!hasRetryButton) {
            make.bottom.equalTo(self.containerView.mas_bottom);
        }
    }];
    
    if (hasRetryButton) {
        [self.retryButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textLabel.mas_bottom).offset(20.f);
            make.centerX.equalTo(self.containerView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100.f, 34.f));
            make.bottom.equalTo(self.containerView.mas_bottom);
        }];
    }
}

#pragma mark - Interfaces -

- (void)setRetryButtonTitle:(NSString *)title eventHandler:(void (^)(void))eventHandler {
    if (title.length) {
        _retryTitle = title;
        [self.retryButton setTitle:title forState:UIControlStateNormal];
        self.retryHandler = eventHandler;
        [self.containerView addSubview:self.retryButton];
    } else {
        _retryTitle = nil;
        self.retryHandler = nil;
        [self.retryButton removeFromSuperview];
    }
    [self layoutContentViews];
}

#pragma mark - Actions -

- (void)didClickRetryButton:(UIButton *)sender {
    !self.retryHandler ?: self.retryHandler();
}

#pragma mark - Setters -

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
    [self layoutContentViews];
}

- (void)setPrompt:(NSString *)prompt {
    _prompt = [prompt copy];
    self.textLabel.text = _prompt;
    [self layoutContentViews];
}

#pragma mark - Getters -

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.image = _image;
    }
    return _imageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = NEFontRegular(14);
        _textLabel.textColor = RGBColor(0x999999);
        _textLabel.numberOfLines = 0;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.preferredMaxLayoutWidth = kLimitWidth;
        _textLabel.text = _prompt;
    }
    return _textLabel;
}

- (UIButton *)retryButton {
    if (!_retryButton) {
        _retryButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        _retryButton.backgroundColor = [UIColor clearColor];
        _retryButton.layer.cornerRadius = 17.f;
        _retryButton.clipsToBounds = YES;
        _retryButton.titleLabel.font = NEFontMedium(15);
        [_retryButton setBackgroundColor:ThemeColor];
        [_retryButton addTarget:self action:@selector(didClickRetryButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryButton;
}

@end
