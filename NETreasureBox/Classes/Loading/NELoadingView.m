//
//  NELoadingView.m
//  WallGrass
//
//  Created by WangSen on 2020/12/5.
//

#import "NELoadingView.h"

@interface NELoadingView ()

@property (nonatomic, strong) UILabel * textLabel;
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) UIActivityIndicatorView * indicatorView;

@end

@implementation NELoadingView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createViewHierarchy];
        [self layoutContentViews];
    }
    return self;
}

- (void)createViewHierarchy {
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.indicatorView];
    [self.containerView addSubview:self.textLabel];
}

- (void)layoutContentViews {
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(MIN(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) * 0.4);
    }];
    
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView.mas_centerX);
        make.top.equalTo(self.containerView.mas_top).offset(20.f);
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.indicatorView.mas_bottom).offset(10.f);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_lessThanOrEqualTo(110.f);
        make.bottom.equalTo(self.containerView.mas_bottom).offset(-14.f);
    }];
}

#pragma mark - Interfaces -

- (void)startLoading {
    [self.indicatorView startAnimating];
}

- (void)stopLoading {
    [self.indicatorView stopAnimating];
}

#pragma mark - Setters -

- (void)setText:(NSString *)text {
    _text = [text copy];
    self.textLabel.text = _text;
}

#pragma mark - Getters -

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
        _containerView.layer.cornerRadius = 10.f;
    }
    return _containerView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _indicatorView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = NEFontMedium(14);
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.numberOfLines = 0;
        _textLabel.preferredMaxLayoutWidth = 110.f;
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

@end
