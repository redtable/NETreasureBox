//
//  NEAlertView.h
//  WallGrass
//
//  Created by WangSen on 2021/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NEAlertView : UIView

+ (instancetype)alertWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message;

- (void)addTextFieldMessage:(NSString *)message actionBlock:(void(^)(NSString * text))actionBlock;
- (void)addLinkMessage:(NSString *)message actionBlock:(void(^ _Nullable)(void))actionBlock;
- (void)addButtonMessage:(NSString *)message actionBlock:(void(^ _Nullable)(void))actionBlock;

- (void)showInView:(UIView *)view;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
