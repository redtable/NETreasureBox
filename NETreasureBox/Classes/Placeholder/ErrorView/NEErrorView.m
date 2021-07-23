//
//  NEErrorView.m
//  WallGrass
//
//  Created by WangSen on 2020/12/8.
//

#import "NEErrorView.h"
#import <objc/runtime.h>

@implementation NEErrorView

+ (void)setDefaultErrorImage:(UIImage *)image {
    objc_setAssociatedObject(self, @selector(defaultErrorImage), image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)defaultErrorImage {
    return objc_getAssociatedObject(self, @selector(defaultErrorImage));
}

+ (void)setDefaultErrorPrompt:(NSString *)prompt {
    objc_setAssociatedObject(self, @selector(defaultErrorPrompt), prompt, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSString *)defaultErrorPrompt {
    return objc_getAssociatedObject(self, @selector(defaultErrorPrompt));
}

+ (void)setDefaultErrorRetryText:(NSString *)retryText {
    objc_setAssociatedObject(self, @selector(defaultErrorRetryText), retryText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSString *)defaultErrorRetryText {
    return objc_getAssociatedObject(self, @selector(defaultErrorRetryText));
}

#pragma mark - Instance -

- (instancetype)initWithEventHandler:(void(^)(void))eventHandler {
    return [self initWithImage:[NEErrorView defaultErrorImage] prompt:[NEErrorView defaultErrorPrompt] retryText:[NEErrorView defaultErrorRetryText] eventHandler:eventHandler];
}

- (instancetype)initWithImage:(UIImage * _Nullable)image prompt:(NSString *)prompt retryText:(NSString *)retryText eventHandler:(void(^)(void))eventHandler {
    NEErrorView * view = [self initWithImage:image prompt:prompt];
    [view setRetryButtonTitle:retryText eventHandler:eventHandler];
    return view;
}

@end
