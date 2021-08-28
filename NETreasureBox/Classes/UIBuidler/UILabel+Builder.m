//
//  UILabel+Builder.m
//  NETreasureBox
//
//  Created by WangSen on 2021/8/28.
//

#import "UILabel+Builder.h"

@implementation UILabel (Builder)

+ (instancetype)buildLabel {
    return [UILabel buildLabelWithFont:nil textColor:nil textAlignment:NSTextAlignmentLeft text:nil];
}

+ (instancetype)buildLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    return [UILabel buildLabelWithFont:font textColor:textColor textAlignment:NSTextAlignmentLeft text:nil];
}

+ (instancetype)buildLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text {
    return [UILabel buildLabelWithFont:font textColor:textColor textAlignment:NSTextAlignmentLeft text:text];
}

+ (instancetype)buildLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    return [UILabel buildLabelWithFont:font textColor:textColor textAlignment:textAlignment text:nil];
}

+ (instancetype)buildLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text {
    UILabel * label = [[UILabel alloc] init];
    label.font = font;
    label.textAlignment = textAlignment;
    label.textColor = textColor;
    label.text = text;
    return label;
}

@end
