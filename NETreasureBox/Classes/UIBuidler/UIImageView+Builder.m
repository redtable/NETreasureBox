//
//  UIImageView+Builder.m
//  NETreasureBox
//
//  Created by WangSen on 2021/8/28.
//

#import "UIImageView+Builder.h"

@implementation UIImageView (Builder)

+ (instancetype)buildImageView {
    return [UIImageView buildImageViewWithImage:nil cornerRadius:0];
}

+ (instancetype)buildImageViewWithImage:(UIImage *)image {
    return [UIImageView buildImageViewWithImage:image cornerRadius:0];
}

+ (instancetype)buildImageViewWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius {
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = image;
    if (cornerRadius > 0) {
        imageView.layer.cornerRadius = cornerRadius;
        imageView.layer.masksToBounds = YES;
    }
    return imageView;
}

@end
