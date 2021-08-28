//
//  UILabel+Builder.h
//  NETreasureBox
//
//  Created by WangSen on 2021/8/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Builder)

+ (instancetype)buildWithFont:(UIFont *)font textColor:(UIColor *)textColor;

+ (instancetype)buildWithFont:(UIFont *)font textColor:(UIColor *)textColor text:(NSString * _Nullable)text;

+ (instancetype)buildWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

+ (instancetype)buildWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString * _Nullable)text;

@end

NS_ASSUME_NONNULL_END
