//
//  UIView+Builder.m
//  NETreasureBox
//
//  Created by WangSen on 2021/8/28.
//

#import "UIView+Builder.h"

@implementation UIView (Builder)

+ (instancetype)build {
    return [UIView buildWithBackgroundColor:nil cornerRadius:0];
}

+ (instancetype)buildWithBackgroundColor:(UIColor *)backgroundColor {
    return [UIView buildWithBackgroundColor:backgroundColor cornerRadius:0];
}

+ (instancetype)buildWithBackgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius {
    UIView * view = [[UIView alloc] init];
    if (backgroundColor) {
        view.backgroundColor = backgroundColor;
    }
    if (cornerRadius > 0) {
        view.layer.cornerRadius = cornerRadius;
        view.layer.maskedCorners = YES;
    }
    return view;
}

@end
