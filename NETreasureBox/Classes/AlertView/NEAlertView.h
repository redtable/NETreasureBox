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

- (void)addLinkMessage:(NSString *)link actionBlock:(void(^ _Nullable)(void))actionBlock;
- (void)addButtonMessage:(NSString *)link actionBlock:(void(^ _Nullable)(void))actionBlock;

- (void)showInView:(UIView *)view;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
