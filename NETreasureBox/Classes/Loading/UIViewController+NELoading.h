//
//  UIViewController+NELoading.h
//  WallGrass
//
//  Created by WangSen on 2020/12/5.
//

#import <UIKit/UIKit.h>
#import "UIView+NELoading.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NELoading)

@property (nonatomic, strong, readonly, nullable) UIView * ne_loadingView;

- (void)ne_startLoading;
- (void)ne_startLoadingWithPrompt:(NSString * _Nullable)prompt;

- (void)ne_stopLoading;

@end

NS_ASSUME_NONNULL_END
