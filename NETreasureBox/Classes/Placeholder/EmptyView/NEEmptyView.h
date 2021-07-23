//
//  NEEmptyView.h
//  WallGrass
//
//  Created by WangSen on 2020/12/8.
//

#import "NEPlaceholderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NEEmptyView : NEPlaceholderView

+ (void)setDefaultEmptyImage:(UIImage *)image;
+ (void)setDefaultEmptyPrompt:(NSString *)prompt;

- (instancetype)initWithImage:(UIImage * _Nullable)image emptyPrompt:(NSString *)emptyPrompt;

@end

NS_ASSUME_NONNULL_END
