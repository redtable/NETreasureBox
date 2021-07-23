//
//  NEToastView.m
//  WallGrass
//
//  Created by WangSen on 2020/12/5.
//

#import "NEToastView.h"

@interface NEToastView ()

@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) UILabel * textLabel;


@end

@implementation NEToastView

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
    [self.containerView addSubview:self.textLabel];
}

- (void)layoutContentViews {
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(200.f);
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).offset(14.f);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_lessThanOrEqualTo(160.f);
        make.bottom.equalTo(self.containerView).offset(-14.f);
    }];
}

#pragma mark - Setters -

- (void)setToastText:(NSString *)toastText {
    if (!toastText || toastText.length == 0) {
        return;
    }
    _toastText = [toastText copy];
    self.textLabel.text = _toastText;
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

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = NEFontMedium(14);
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.numberOfLines = 0;
        _textLabel.preferredMaxLayoutWidth = 160.f;
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

@end
