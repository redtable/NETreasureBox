//
//  NEPlaceholderView.h
//  WallGrass
//
//  Created by WangSen on 2020/12/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NEPlaceholderView : UIView

@property (nonatomic, strong) UIImage * image;
@property (nonatomic, copy) NSString * prompt;
@property (nonatomic, copy) NSString * retryTitle;

- (instancetype)initWithImage:(UIImage * _Nullable)image prompt:(NSString * _Nullable)prompt;

- (void)setRetryButtonTitle:(NSString * _Nullable)title eventHandler:(void(^ _Nullable)(void))eventHandler;

@end

NS_ASSUME_NONNULL_END
