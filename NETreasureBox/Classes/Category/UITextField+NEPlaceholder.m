//
//  UITextField+NEPlaceholder.m
//  WallGrass
//
//  Created by WangSen on 2021/1/8.
//

#import "UITextField+NEPlaceholder.h"

@implementation UITextField (NEPlaceholder)

- (void)setPlaceholder:(NSString *)placeholder {
    NSAttributedString * attPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName : RGBColor(0x333333)}];
    self.attributedPlaceholder = attPlaceholder;
}

@end
