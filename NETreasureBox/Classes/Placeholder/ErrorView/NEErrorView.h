//
//  NEErrorView.h
//  WallGrass
//
//  Created by WangSen on 2020/12/8.
//

#import "NEPlaceholderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NEErrorView : NEPlaceholderView

+ (void)setDefaultErrorImage:(UIImage *)image;
+ (void)setDefaultErrorPrompt:(NSString *)prompt;
+ (void)setDefaultErrorRetryText:(NSString *)retryText;

- (instancetype)initWithEventHandler:(void(^)(void))eventHandler;

- (instancetype)initWithImage:(UIImage * _Nullable)image prompt:(NSString *)prompt retryText:(NSString *)retryText eventHandler:(void(^)(void))eventHandler;

@end

NS_ASSUME_NONNULL_END
