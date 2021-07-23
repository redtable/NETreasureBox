//
//  UIViewController+NEPlaceholder.h
//  WallGrass
//
//  Created by WangSen on 2020/12/8.
//

#import <UIKit/UIKit.h>
#import "UIView+NEPlaceholder.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NEPlaceholder)

@property (nonatomic, strong, nullable) __kindof UIView * ne_emptyView;
@property (nonatomic, strong, nullable) __kindof UIView * ne_errorView;

- (void)ne_showEmptyViewBelowSubview:(UIView *)subview;
- (void)ne_showEmptyView;
- (void)ne_hideEmptyView;

- (void)ne_showErrorViewBelowSubview:(UIView *)subview;
- (void)ne_showErrorView;
- (void)ne_hideErrorView;

@end

NS_ASSUME_NONNULL_END
