//
//  UIViewController+NENavigationBar.m
//  WallGrass
//
//  Created by WangSen on 2020/12/4.
//

#import "UIViewController+NENavigationBar.h"
#import <objc/runtime.h>

@implementation UIViewController (NENavigationBar)

- (UIView *)ne_navigationBar {
    UIView * navigationBar = objc_getAssociatedObject(self, _cmd);
    if (!navigationBar) {
        navigationBar = [[UIView alloc] init];
        navigationBar.frame = CGRectMake(0.f, 0.f, NEScreenCurrentWidth, NEStatusAndNavigationBarHeight);
        navigationBar.backgroundColor = [UIColor clearColor];
        UIView * bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = RGBColor(0xCCCCCC);
        bottomLine.frame = CGRectMake(0, navigationBar.height - NEOnePx, navigationBar.width, NEOnePx);
        [navigationBar addSubview:bottomLine];
        objc_setAssociatedObject(self, _cmd, navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return navigationBar;
}

@end
