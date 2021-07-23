//
//  NEMacro.h
//  WallGrass
//
//  Created by WangSen on 2020/12/2.
//

#import "NEBaseUtils.h"

#ifndef NEMacro_h
#define NEMacro_h

#if DEBUG
#else
    #define NSLog(fmt, ...) // Do nothing...
#endif

#define NEScreenCurrentWidth  CGRectGetWidth([UIScreen mainScreen].bounds)
#define NEScreenCurrentHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#define NEStatusAndNavigationBarHeight [NEBaseUtils screenStatusNavigationBarHeight]
#define NEStatusBarHeight [NEBaseUtils screenStatusBarHeight]
#define NEBottomHeight [NEBaseUtils screenBottomHeight]
#define NEIsNotchScreen [NEBaseUtils isNotchScreen]
#define NEKeyWindow [NEBaseUtils keyWindow]
#define NEImageFile(fileName) [UIImage imageNamed:fileName]

#define NEFontRegular(fontSize) [UIFont fontWithName:@"PingFangTC-Light" size:fontSize]
#define NEFontMedium(fontSize) [UIFont fontWithName:@"PingFangTC-Regular" size:fontSize]
#define NEFontBold(fontSize) [UIFont fontWithName:@"PingFangTC-Semibold" size:fontSize]
//#define NEFontRegular(fontSize) [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight]
//#define NEFontMedium(fontSize) [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular]
//#define NEFontBold(fontSize) [UIFont systemFontOfSize:fontSize weight:UIFontWeightBold]

#define NEOnePx (1.f / kScreenScale)
#define NELocalizedString(string) NSLocalizedString(string, nil)

#define ThemeColor RGBColor(0x00788B)

#ifndef RGBColor
#define RGBColor(_hex_) UIColorHex(_hex_)
#endif

#ifndef RGBAColor
#define RGBAColor(_hex_, _alpha_) [UIColor colorWithRGB:_hex_ alpha:_alpha_]
#endif

#define NEPostNotification(name, obj, userinfo) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj userInfo:userinfo]

#define NEAddActionLog(FORMAT, ...) [[NELogManager manager] addActionLog:FORMAT, ##__VA_ARGS__];
#define NEAddNetworkLog(FORMAT, ...) [[NELogManager manager] addNetworkLog:FORMAT, ##__VA_ARGS__];
#define NEAddErrorLog(FORMAT, ...) [[NELogManager manager] addErrorLog:FORMAT, ##__VA_ARGS__];

#endif /* NEMacro_h */
