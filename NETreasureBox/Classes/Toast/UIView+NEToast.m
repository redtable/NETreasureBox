//
//  UIView+NEToast.m
//  WallGrass
//
//  Created by WangSen on 2020/12/5.
//

#import "UIView+NEToast.h"
#import "NEToastView.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) NEToastView * toastView;

@end

@implementation UIView (NEToast)

#pragma mark - Interfaces -

- (void)ne_toast:(NSString *)info {
    [self ne_toast:info dismissDelay:2.f];
}

- (void)ne_toast:(NSString *)info dismissDelay:(NSTimeInterval)delay {
    delay = MAX(delay, 0.5f);
    
    [self ne_dismissToast];
        
    NEToastView * toastView = self.toastView;
    toastView.toastText = info;
    [self addSubview:toastView];
    
    [toastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self ne_dismissToast];
    });
}

- (void)ne_dismissToast {
    NEToastView * toastView = self.toastView;
    if (!toastView.superview) {
        return;
    }
    [toastView removeFromSuperview];
}

#pragma mark - Getters -

- (NEToastView *)toastView {
    NEToastView * toastView = objc_getAssociatedObject(self, _cmd);
    if (!toastView) {
        toastView = [[NEToastView alloc] init];
        toastView.backgroundColor = [UIColor clearColor];
        toastView.userInteractionEnabled = NO;
        objc_setAssociatedObject(self, _cmd, toastView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return toastView;
}

@end
