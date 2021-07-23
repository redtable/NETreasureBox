//
//  UIView+NEBackground.m
//  WallGrass
//
//  Created by WangSen on 2020/12/19.
//

#import "UIView+NEBackground.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) CAGradientLayer * gradientBackgroundLayer;

@end

@implementation UIView (NEBackground)

- (void)addGradientBackground {
    [self.layer addSublayer:self.gradientBackgroundLayer];
}

- (void)setGradientBackgroundLayer:(CAGradientLayer *)gradientBackgroundLayer {
    objc_setAssociatedObject(self, @selector(gradientBackgroundLayer), gradientBackgroundLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAGradientLayer *)gradientBackgroundLayer {
    CAGradientLayer * layer = objc_getAssociatedObject(self, @selector(gradientBackgroundLayer));
    UIColor * startColor = RGBColor(0xEEEEE0);
    UIColor * endColor = RGBColor(0xF1F2C3);
    if (!layer) {
        layer = [CAGradientLayer layer];
        layer.frame = self.bounds;
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(0, 1);
        layer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
        layer.locations = @[@(0), @(1.0f)];
        [self setGradientBackgroundLayer:layer];
    }
    return layer;
}

@end
