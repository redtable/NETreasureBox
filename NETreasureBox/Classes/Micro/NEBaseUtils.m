//
//  NEBaseUtils.m
//  WallGrass
//
//  Created by WangSen on 2020/12/2.
//

#import "NEBaseUtils.h"

@implementation NEBaseUtils

+ (UIWindow *)keyWindow {
    UIWindow * keyWindow = [UIApplication sharedApplication].delegate.window;
    if (!keyWindow) {
        keyWindow = [UIApplication sharedApplication].windows.firstObject;
    }
    return keyWindow;
}

+ (CGFloat)screenStatusBarHeight {
    static CGFloat statusBarHeight = 0.f;
    if (statusBarHeight > 0) {
        return statusBarHeight;
    }
    CGSize statusBarSize = CGSizeZero;
    if (@available(iOS 13.0, *)) {
        UIWindow * keyWindow = [NEBaseUtils keyWindow];
        statusBarSize = keyWindow.windowScene.statusBarManager.statusBarFrame.size;
    } else {
        statusBarSize = [UIApplication sharedApplication].statusBarFrame.size;
    }
    statusBarHeight = MIN(statusBarSize.width, statusBarSize.height);
    return statusBarHeight;
}

+ (BOOL)isNotchScreen {
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return NO;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow * keyWindow = [NEBaseUtils keyWindow];
        if (keyWindow.safeAreaInsets.bottom <= 0.0) {
            return NO;
        }
        return YES;
    }
    return NO;
}

+ (CGFloat)screenStatusNavigationBarHeight {
    CGFloat navigationBarHeight = 44.f;
    return [NEBaseUtils screenStatusBarHeight] + navigationBarHeight;
}

+ (CGFloat)screenBottomHeight {
    if (@available(iOS 11.0, *)) {
        UIWindow * keyWindow = [NEBaseUtils keyWindow];
        return keyWindow.safeAreaInsets.bottom;
    }
    return 0.f;
}

@end
