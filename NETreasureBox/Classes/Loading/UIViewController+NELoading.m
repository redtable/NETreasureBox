//
//  UIViewController+NELoading.m
//  WallGrass
//
//  Created by WangSen on 2020/12/5.
//

#import "UIViewController+NELoading.h"

@implementation UIViewController (NELoading)

#pragma mark - Interfaces -

- (void)ne_startLoadingWithPrompt:(NSString * _Nullable)prompt {
    [self.view ne_startLoadingWithPrompt:prompt];
}

- (void)ne_startLoading {
    [self.view ne_startLoading];
}

- (void)ne_stopLoading {
    [self.view ne_stopLoading];
}

#pragma mark - Getters -

- (UIView *)ne_loadingView {
    return self.view.ne_loadingView;
}

@end
