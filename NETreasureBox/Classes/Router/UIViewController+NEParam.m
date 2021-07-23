//
//  UIViewController+NEParam.m
//  WallGrass
//
//  Created by WangSen on 2020/12/23.
//

#import "UIViewController+NEParam.h"
#import <objc/runtime.h>

@implementation UIViewController (NEParam)

- (void)setParams:(NSDictionary *)params {
    objc_setAssociatedObject(self, @selector(params), params, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)params {
    return objc_getAssociatedObject(self, _cmd);
}

@end
