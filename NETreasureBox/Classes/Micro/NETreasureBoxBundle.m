//
//  NETreasureBoxBundle.m
//  NETreasureBox
//
//  Created by WangSen on 2021/8/28.
//

#import "NETreasureBoxBundle.h"

@implementation NETreasureBoxBundle

+ (NSBundle *)bundle {
    NSBundle *bundle = [NSBundle bundleForClass:[NETreasureBoxBundle class]];
    // `NETreasureBox-res` 的值需要与 podspec 中的值保持相同
    NSString *bundlePath = [bundle pathForResource:@"NETreasureBox-res" ofType:@"bundle"];
    NSBundle *resBundle = [NSBundle bundleWithPath:bundlePath];
    return resBundle;
}

@end
