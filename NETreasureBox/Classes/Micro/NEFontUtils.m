//
//  NEFontUtils.m
//  NETreasureBox
//
//  Created by WangSen on 2021/8/28.
//

#import "NEFontUtils.h"
#import <CoreText/CTFontManager.h>
#import "NETreasureBoxBundle.h"

NSString * NEGetFontFileName(NSString * fontName) {
    NSDictionary * info = @{
        @"SourceHanSansCN-Bold" : @"SourceHanSansCN-Bold.otf",
        @"SourceHanSansCN-Medium" : @"SourceHanSansCN-Medium.otf",
        @"SourceHanSansCN-Regular" : @"SourceHanSansCN-Regular.otf",
    };
    if (!fontName) {
        return nil;
    }
    return [info objectForKey:fontName];
}

void NELoadFontFile(NSString * fontFileName) {
    NSString * resourcePath = [NSString stringWithFormat:@"%@/%@", NETreasureBoxBundle.bundle.bundlePath, fontFileName];
    NSURL * url = [NSURL fileURLWithPath:resourcePath];
        
    NSData * fontData = [NSData dataWithContentsOfURL:url];
    if (fontData) {
        CFErrorRef error;
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
        CGFontRef font = CGFontCreateWithDataProvider(provider);
        if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            CFRelease(errorDescription);
        }
        CFRelease(font);
        CFRelease(provider);
    }
}

UIFont * NEGetFont(NSString * fontName, CGFloat size) {
    UIFont * font = [UIFont fontWithName:fontName size:size];
    if (font) {
        return font;
    }
    NSString * fontFileName = NEGetFontFileName(fontName);
    if (!fontFileName) {
        return [UIFont systemFontOfSize:size];
    }
    NELoadFontFile(fontFileName);
    font = [UIFont fontWithName:fontName size:size];
    if (font) {
        return font;
    }
    return [UIFont systemFontOfSize:size];
}
