//
//  UIViewController+NEPlaceholder.m
//  WallGrass
//
//  Created by WangSen on 2020/12/8.
//

#import "UIViewController+NEPlaceholder.h"
#import "UIView+NEPlaceholder.h"
#import "NEEmptyView.h"
#import "NEErrorView.h"
#import <objc/runtime.h>

@implementation UIViewController (NEPlaceholder)

#pragma mark - Interfaces -

- (void)ne_showEmptyViewBelowSubview:(UIView *)subview {
    self.view.ne_emptyView = self.ne_emptyView;
    [self.view ne_showEmptyViewBelowSubview:subview];
}

- (void)ne_showEmptyView {
    self.view.ne_emptyView = self.ne_emptyView;
    [self.view ne_showEmptyView];
}

- (void)ne_hideEmptyView {
    [self.view ne_hideEmptyView];
}

- (void)ne_showErrorViewBelowSubview:(UIView *)subview {
    self.view.ne_errorView = self.ne_errorView;
    [self.view ne_showErrorViewBelowSubview:subview];
}

- (void)ne_showErrorView {
    self.view.ne_errorView = self.ne_errorView;
    [self.view ne_showErrorView];
}

- (void)ne_hideErrorView {
    [self.view ne_hideErrorView];
}

#pragma mark - Setters -

- (void)setNe_emptyView:(__kindof UIView *)ne_emptyView {
    self.view.ne_emptyView = ne_emptyView;
    if (ne_emptyView) {
        objc_setAssociatedObject(self, @selector(ne_emptyView), ne_emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setNe_errorView:(__kindof UIView *)ne_errorView {
    self.view.ne_errorView = ne_errorView;
    if (ne_errorView) {
        objc_setAssociatedObject(self, @selector(ne_errorView), ne_errorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
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
