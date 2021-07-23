//
//  UIView+NEToast.h
//  WallGrass
//
//  Created by WangSen on 2020/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (NEToast)

- (void)ne_toast:(NSString *)info;
- (void)ne_toast:(NSString *)info dismissDelay:(NSTimeInterval)delay;

- (void)ne_dismissToast;

@end

NS_ASSUME_NONNULL_END
