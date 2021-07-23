//
//  UIViewController+NELog.m
//  WallGrass
//
//  Created by WangSen on 2021/1/22.
//

#import "UIViewController+NELog.h"

@implementation UIViewController (NELog)

+ (void)load {
    [UIViewController swizzleInstanceMethod:@selector(viewDidAppear:) with:@selector(ne_viewDidAppear:)];
}

- (void)ne_viewDidAppear:(BOOL)animated {
    NEAddActionLog(@"Enter %@", self.className);
    [self ne_viewDidAppear:animated];
}

@end
