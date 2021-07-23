//
//  UIView+NEPlaceholder.m
//  WallGrass
//
//  Created by WangSen on 2020/12/8.
//

#import "UIView+NEPlaceholder.h"
#import "NEEmptyView.h"
#import "NEErrorView.h"
#import <objc/runtime.h>

@implementation UIView (NEPlaceholder)

#pragma mark - Interfaces -

- (void)ne_showEmptyViewBelowSubview:(UIView *)subview {
    self.ne_emptyView.frame = self.bounds;
    if (subview) {
        [self insertSubview:self.ne_emptyView belowSubview:subview];
    } else {
        [self addSubview:self.ne_emptyView];
    }
}

- (void)ne_showEmptyView {
    if (CGRectEqualToRect(self.ne_emptyView.frame, CGRectZero) || CGRectEqualToRect(self.ne_emptyView.frame, CGRectNull)) {
        self.ne_emptyView.frame = self.bounds;
    }
    [self addSubview:self.ne_emptyView];
    [self bringSubviewToFront:self.ne_emptyView];
}

- (void)ne_hideEmptyView {
    [self.ne_emptyView removeFromSuperview];
}

- (void)ne_showErrorViewBelowSubview:(UIView *)subview {
    self.ne_errorView.frame = self.bounds;
    if (subview) {
        [self insertSubview:self.ne_errorView belowSubview:subview];
    } else {
        [self addSubview:self.ne_errorView];
    }
}

- (void)ne_showErrorView {
    self.ne_errorView.frame = self.bounds;
    [self addSubview:self.ne_errorView];
    [self bringSubviewToFront:self.ne_errorView];
}

- (void)ne_hideErrorView {
    [self.ne_errorView removeFromSuperview];
}

#pragma mark - Setters -

- (void)setNe_emptyView:(__kindof UIView *)ne_emptyView {
    [self ne_hideEmptyView];
    objc_setAssociatedObject(self, @selector(ne_emptyView), ne_emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNe_errorView:(__kindof UIView *)ne_errorView {
    [self ne_hideErrorView];
    objc_setAssociatedObject(self, @selector(ne_errorView), ne_errorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Getters -

- (UIView *)ne_emptyView {
    UIView * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [[NEEmptyView alloc] init];
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (UIView *)ne_errorView {
    UIView * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        @weakify(self);
        view = [[NEErrorView alloc] initWithEventHandler:^{
            @strongify(self);
            if ([self respondsToSelector:@selector(neErrorViewDidClickRetryButtonAction:)]) {
                [self performSelector:@selector(neErrorViewDidClickRetryButtonAction:) withObject:nil];
            }
        }];
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

@end
