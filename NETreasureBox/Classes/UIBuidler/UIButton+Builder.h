//
//  UIButton+Builder.h
//  NETreasureBox
//
//  Created by WangSen on 2021/8/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Builder)

+ (instancetype)buildButtonWithImage:(UIImage * _Nullable)image actionBlock:(void(^)(id sender))actionBlock;

+ (instancetype)buildButtonWithText:(NSString * _Nullable)text textColor:(UIColor * _Nullable)textColor font:(UIFont * _Nullable)font actionBlock:(void(^)(id sender))actionBlock;

+ (instancetype)buildButtonWithText:(NSString * _Nullable)text textColor:(UIColor * _Nullable)textColor font:(UIFont * _Nullable)font image:(UIImage * _Nullable)image backgroundImage:(UIImage * _Nullable)backgroundImage backgroundColor:(UIColor * _Nullable)backgroundColor actionBlock:(void(^)(id sender))actionBlock;

@end

NS_ASSUME_NONNULL_END
