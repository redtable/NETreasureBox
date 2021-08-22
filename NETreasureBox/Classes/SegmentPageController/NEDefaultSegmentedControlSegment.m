//
//  NEDefaultSegmentedControlSegment.m
//  NEStudentEmbeddedSDK
//
//  Created by liang on 2020/1/15.
//

#import "NEDefaultSegmentedControlSegment.h"
//#import <NEShadowView.h>
//#import <UILabel+NEBuild.h>
#import <NSString+YYAdd.h>

static CGFloat const kMarkLabelHeight = 13.f;
static CGFloat const kMarkBackgroundViewHeight = 16.f;

@interface NEDefaultSegmentedControlSegment ()

@property (nonatomic, strong) UILabel *markLabel;
@property (nonatomic, strong) UIView *markBackgroundView;
//@property (nonatomic, strong) NEShadowView *shadowView;

@end

@implementation NEDefaultSegmentedControlSegment

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInit];
        [self createViewHierarchy];
        [self layoutContentViews];
    }
    return self;
}

- (void)commitInit {
    self.backgroundColor = RGBColor(0xFFFFFF);
    self.textLabel.font = NEFontMedium(15);
    self.textLabel.textColor = RGBColor(0x666666);
//    self.shadowView.hidden = self.markLabel.hidden = self.markBackgroundView.hidden = YES;
}

- (void)createViewHierarchy {
    [self.contentView addSubview:self.textLabel];
    [self.contentView addSubview:self.markBackgroundView];
    [self.contentView addSubview:self.markLabel];
//    [self.contentView insertSubview:self.shadowView belowSubview:self.markBackgroundView];
}

- (void)layoutContentViews {
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-12.f);
    }];
    
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel.mas_right).offset(5);
        make.height.mas_equalTo(kMarkLabelHeight);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-27.f);
        make.width.mas_greaterThanOrEqualTo(kMarkLabelHeight);
    }];
    
    [self.markBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.markLabel);
        make.width.mas_equalTo(self.markLabel.mas_width).offset(3.f);
        make.height.mas_equalTo(kMarkBackgroundViewHeight);
    }];
    
//    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.markBackgroundView);
//    }];
}

#pragma mark - Public Methods
- (void)setText:(NSString *)text {
    self.textLabel.text = text ?: @"";
}

- (void)setMarkCount:(NSInteger)markCount {
    NSString *text = nil;
    if (markCount <= 0) {
        text = nil;
    } else if (markCount > 99) {
        text = @"...";
    } else {
        text = [NSString stringWithFormat:@"%zd", markCount];
    }
    [self setMarkText:text];
}

- (void)setMarkText:(NSString *)markText {
    self.markLabel.text = markText ?: @"";
    
    BOOL shouldHidden = !(markText.length > 0);
//    self.shadowView.hidden = self.markLabel.hidden = self.markBackgroundView.hidden = shouldHidden;
}

+ (CGFloat)widthByText:(NSString *)text {
    if (!text.length) { return 0.f; }
    
    return [text widthForFont:NEFontMedium(15)];
}

#pragma mark - Getter Methods
- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [[UILabel alloc] init];
        _markLabel.textColor = [UIColor whiteColor];
        _markLabel.font = NEFontMedium(11);
        _markLabel.textAlignment = NSTextAlignmentCenter;
//        _markLabel = [UILabel building:nil
//                       backgroundColor:[UIColor clearColor]
//                             textColor:RGBColor(0xFFFFFF)
//                                  font:NEFontSFMedium(11)
//                         textAlignment:NSTextAlignmentCenter
//                         numberOfLines:1];
    }
    return _markLabel;
}

- (UIView *)markBackgroundView {
    if (!_markBackgroundView) {
        _markBackgroundView = [[UIView alloc] init];
        _markBackgroundView.backgroundColor = RGBColor(0xFC3A1C);
        _markBackgroundView.layer.cornerRadius = kMarkBackgroundViewHeight / 2.f;
        _markBackgroundView.clipsToBounds = YES;
    }
    return _markBackgroundView;
}

//- (NEShadowView *)shadowView {
//    if (!_shadowView) {
//        _shadowView = [[NEShadowView alloc] init];
//        _shadowView.shadowColor = RGBColor(0xCC00FF);
//        _shadowView.shadowRadius = 3.f;
//        _shadowView.cornerRadius = kMarkBackgroundViewHeight / 2.f;
//        _shadowView.shadowOffset = CGSizeMake(0.f, 0.f);
//        _shadowView.shadowOpacity = 0.5f;
//    }
//    return _shadowView;
//}

@end

@implementation NEDefaultSegmentedControlSelectedSegment

#pragma mark - Override Methods
- (void)commitInit {
    [super commitInit];
    
    self.textLabel.font = NEFontBold(24);
    self.textLabel.textColor = RGBColor(0x1E1E1E);
}

#pragma mark - Public Methods
+ (CGFloat)widthByText:(NSString *)text {
    if (!text.length) { return 0.f; }
    
    return [text widthForFont:NEFontBold(24)];
}

@end
