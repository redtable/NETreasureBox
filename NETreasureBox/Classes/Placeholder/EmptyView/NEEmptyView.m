//
//  NEEmptyView.m
//  WallGrass
//
//  Created by WangSen on 2020/12/8.
//

#import "NEEmptyView.h"
#import <objc/runtime.h>

@implementation NEEmptyView

+ (void)setDefaultEmptyImage:(UIImage *)image {
    objc_setAssociatedObject(self, @selector(defaultEmptyImage), image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)defaultEmptyImage {
    return objc_getAssociatedObject(self, @selector(defaultEmptyImage));
}

+ (void)setDefaultEmptyPrompt:(NSString *)prompt {
    objc_setAssociatedObject(self, @selector(defaultEmptyPrompt), prompt, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSString *)defaultEmptyPrompt {
    return objc_getAssociatedObject(self, @selector(defaultEmptyPrompt));
}

#pragma mark - Instance -

- (instancetype)init {
    return [self initWithImage:[NEEmptyView defaultEmptyImage] emptyPrompt:[NEEmptyView defaultEmptyPrompt]];
}

- (instancetype)initWithImage:(UIImage * _Nullable)image emptyPrompt:(NSString *)emptyPrompt {
    return [self initWithImage:image prompt:emptyPrompt];
}

@end
