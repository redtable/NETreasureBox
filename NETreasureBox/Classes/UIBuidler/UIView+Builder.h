//
//  UIView+Builder.h
//  NETreasureBox
//
//  Created by WangSen on 2021/8/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Builder)

+ (instancetype)build;

+ (instancetype)buildWithBackgroundColor:(UIColor *)backgroundColor;

+ (instancetype)buildWithBackgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
