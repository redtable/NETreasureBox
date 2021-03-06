//
//  UIImageView+Builder.h
//  NETreasureBox
//
//  Created by WangSen on 2021/8/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Builder)

+ (instancetype)buildImageView;

+ (instancetype)buildImageViewWithImage:(UIImage * _Nullable)image;

+ (instancetype)buildImageViewWithImage:(UIImage * _Nullable)image cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
