//
//  UIButton+Builder.m
//  NETreasureBox
//
//  Created by WangSen on 2021/8/28.
//

#import "UIButton+Builder.h"

@implementation UIButton (Builder)

+ (instancetype)buildButtonWithImage:(UIImage * _Nullable)image actionBlock:(void(^)(id sender))actionBlock {
    return [UIButton buildButtonWithText:nil textColor:nil font:nil image:image backgroundImage:nil backgroundColor:nil actionBlock:actionBlock];
}

+ (instancetype)buildButtonWithText:(NSString * _Nullable)text textColor:(UIColor * _Nullable)textColor font:(UIFont * _Nullable)font actionBlock:(void(^)(id sender))actionBlock {
    return [UIButton buildButtonWithText:text textColor:textColor font:font image:nil backgroundImage:nil backgroundColor:nil actionBlock:actionBlock];
}

+ (instancetype)buildButtonWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage backgroundColor:(UIColor *)backgroundColor actionBlock:(void(^)(id sender))actionBlock {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (text) {
        [button setTitle:text forState:UIControlStateNormal];
    }
    if (textColor) {
        [button setTitleColor:textColor forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (backgroundImage) {
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    if (backgroundColor) {
        [button setBackgroundColor:backgroundColor];
    }
    if (actionBlock) {
        [button addBlockForControlEvents:UIControlEventTouchUpInside block:actionBlock];
    }
    return button;
}

@end
