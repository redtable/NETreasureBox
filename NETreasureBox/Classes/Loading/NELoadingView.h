//
//  NELoadingView.h
//  WallGrass
//
//  Created by WangSen on 2020/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NELoadingView : UIView

@property (nonatomic, copy) NSString * text;

- (void)startLoading;
- (void)stopLoading;

@end

NS_ASSUME_NONNULL_END
