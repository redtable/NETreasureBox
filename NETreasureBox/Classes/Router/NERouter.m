//
//  NERouter.m
//  WallGrass
//
//  Created by WangSen on 2020/12/23.
//

#import "NERouter.h"

@implementation NERouter

+ (BOOL)openPage:(NSString *)pageName {
    return [NERouter openPage:pageName params:nil];
}

+ (BOOL)openPage:(NSString *)pageName params:(NSDictionary * _Nullable)params {
    if (!pageName.length) {
        return NO;
    }
    __kindof UIViewController * page = [[NSClassFromString(pageName) alloc] init];
    if (!page) {
        return NO;
    }
    page.params = params;
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
    return nil;
}

@end
