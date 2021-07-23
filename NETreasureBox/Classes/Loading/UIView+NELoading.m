//
//  UIView+NELoading.m
//  WallGrass
//
//  Created by WangSen on 2020/12/5.
//

#import "UIView+NELoading.h"
#import "NELoadingView.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) NELoadingView * loadingView;

@end

@implementation UIView (NELoading)

#pragma mark - Interfaces -

- (void)ne_startLoadingWithPrompt:(NSString * _Nullable)prompt {
    [self ne_stopLoading];
    
    NELoadingView * loadingView = self.loadingView;
    [self addSubview:loadingView];
    
    [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [loadingView startLoading];
    loadingView.text = prompt;
}

- (void)ne_startLoading {
    [self ne_startLoadingWithPrompt:NELocalizedString(@"网络连接中等待提示")];
}

- (void)ne_stopLoading {
    NELoadingView *loadingView = self.loadingView;
    if (!loadingView.superview) { return; }
    
    [loadingView stopLoading];
    [loadingView removeFromSuperview];
}

#pragma mark - Getters -

- (NELoadingView *)loadingView {
    NELoadingView *loadingView = objc_getAssociatedObject(self, _cmd);
    
    if (!loadingView) {
        loadingView = [[NELoadingView alloc] init];
        loadingView.backgroundColor = [UIColor clearColor];
        loadingView.userInteractionEnabled = NO;
        objc_setAssociatedObject(self, _cmd, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return loadingView;
}

- (UIView *)ne_loadingView {
    return self.loadingView;
}

@end
