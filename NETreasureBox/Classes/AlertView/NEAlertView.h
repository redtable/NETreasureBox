//
//  NEAlertView.h
//  WallGrass
//
//  Created by WangSen on 2021/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NEAlertButtonStyle) {
    NEAlertButtonStyleNormal = 0,
    NEAlertButtonStyleHighlighted = 1,
};

@interface NEAlertView : UIView

+ (instancetype)alertWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message;

+ (instancetype)alertWithTitle:(NSString * _Nullable)title subTitle:(NSString * _Nullable)subTitle message:(NSString * _Nullable)message;

- (void)addTextFieldMessage:(NSString *)message actionBlock:(void(^)(NSString * text))actionBlock;
- (void)addLinkMessage:(NSString *)message actionBlock:(void(^ _Nullable)(void))actionBlock;
- (void)addButtonMessage:(NSString *)message style:(NEAlertButtonStyle)style actionBlock:(void(^ _Nullable)(void))actionBlock;

- (void)showInView:(UIView *)view;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
