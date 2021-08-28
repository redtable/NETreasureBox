//
//  UILabel+Builder.m
//  NETreasureBox
//
//  Created by WangSen on 2021/8/28.
//

#import "UILabel+Builder.h"

@implementation UILabel (Builder)

+ (instancetype)buildWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    return [UILabel builderWithFont:font textColor:textColor textAlignment:NSTextAlignmentLeft text:nil];
}

+ (instancetype)buildWithFont:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text {
    return [UILabel builderWithFont:font textColor:textColor textAlignment:NSTextAlignmentLeft text:text];
}

+ (instancetype)buildWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    return [UILabel builderWithFont:font textColor:textColor textAlignment:textAlignment text:nil];
}

+ (instancetype)buildWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text {
    UILabel * label = [[UILabel alloc] init];
    label.font = font;
    label.textAlignment = textAlignment;
    label.textColor = textColor;
    label.text = text;
    return label;
}

@end
