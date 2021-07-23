//
//  UIViewController+NEToast.m
//  WallGrass
//
//  Created by WangSen on 2020/12/5.
//

#import "UIViewController+NEToast.h"

@implementation UIViewController (NEToast)

#pragma mark - Interfaces -

- (void)ne_toast:(NSString *)info {
    [self.view ne_toast:info];
}

- (void)ne_toast:(NSString *)info dismissDelay:(NSTimeInterval)delay {
    [self.view ne_toast:info dismissDelay:delay];
}

- (void)ne_dismissToast {
    [self.view ne_dismissToast];
}

@end
