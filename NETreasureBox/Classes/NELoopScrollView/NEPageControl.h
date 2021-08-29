//
//  NEPageControl.h
//  NEBaseSDK
//
//  Created by liang on 2020/4/17.
//

#import <UIKit/UIKit.h>
#import "NELoopScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@class NEPageControl;

@protocol NEPageControlDelegate <NSObject>

- (void)pageControl:(NEPageControl *)pageControl didSelectAtIndex:(NSUInteger)index;

@end

@interface NEPageControl : UIView <NELoopScrollViewPageControl>

@property (nonatomic, weak, nullable) id<NEPageControlDelegate> delegate;
@property (nonatomic, assign) BOOL hidesForSinglePage;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGSize currentPageItemSize;
@property (nonatomic, strong) UIColor *itemColor;
@property (nonatomic, strong) UIColor *currentPageItemColor;
@property (nonatomic, assign) NSTimeInterval animationDuration;

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
