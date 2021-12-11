//
//  NERouter.m
//  WallGrass
//
//  Created by WangSen on 2020/12/23.
//

#import "NERouter.h"
#import "NEWebViewController.h"

@implementation NERouter

+ (BOOL)openPage:(NSString *)pageName {
    return [NERouter openPage:pageName params:nil];
}

+ (BOOL)openPage:(NSString *)pageName params:(NSDictionary * _Nullable)params {
    if (!pageName.length) {
        return NO;
    }
    __kindof UIViewController * page = [[NSClassFromString(pageName) alloc] init];
    if (!page && ([pageName hasPrefix:@"https://"] || [pageName hasPrefix:@"http://"])) {
        page = [[NSClassFromString(@"NEWebViewController") alloc] init];
        NSMutableDictionary * p = [NSMutableDictionary dictionaryWithDictionary:params];
        [p setObject:pageName forKey:@"url"];
        params = p.yy_modelCopy;
    }
    if (!page) {
        return NO;
    }
    page.params = params;
    page.hidesBottomBarWhenPushed = YES;
    UINavigationController * navigationController = self.currentNavigationController;
    if (!navigationController) {
        return NO;
    }
    [navigationController pushViewController:page animated:YES];
    return YES;
}

+ (UINavigationController * _Nullable)currentNavigationController {
    UIViewController * rootViewController = NEKeyWindow.rootViewController;
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)rootViewController;
    }
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController * viewController = ((UITabBarController *)rootViewController).selectedViewController;
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)viewController;
        }
    }
    return nil;
}

@end
