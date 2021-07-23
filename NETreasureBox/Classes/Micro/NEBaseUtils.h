//
//  NEBaseUtils.h
//  WallGrass
//
//  Created by WangSen on 2020/12/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NEBaseUtils : NSObject

+ (UIWindow *)keyWindow;

+ (CGFloat)screenStatusBarHeight;

+ (CGFloat)screenStatusNavigationBarHeight;

+ (CGFloat)screenBottomHeight;

+ (BOOL)isNotchScreen;

@end

NS_ASSUME_NONNULL_END
