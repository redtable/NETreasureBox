//
//  NELoopScrollView.h
//  Student_iPad
//
//  Created by liang on 2019/6/12.
//  Copyright © 2019 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NELoopScrollView;

@protocol NELoopScrollViewPageControl;
@protocol NELoopScrollViewDataSource, NELoopScrollViewDelegate;

typedef NS_ENUM(NSUInteger, NELoopScrollViewDirection) {
    NELoopScrollViewDirectionHorizontal = 0,
    NELoopScrollViewDirectionVertical
};

@interface NELoopScrollView : UIView

@property (nonatomic, weak) id<NELoopScrollViewDataSource> dataSource;
@property (nonatomic, weak) id<NELoopScrollViewDelegate> delegate;

// If secs is 0s, will not scroll automatically.
@property (nonatomic, assign) NSTimeInterval secs;
// Control gestures scrolling, default is YES.
@property (nonatomic, assign, getter=isScrollEnabled) BOOL scrollEnabled;
// Default is NELoopScrollViewDirectionHorizontal.
@property (nonatomic, assign) NELoopScrollViewDirection scrollDirection;
// Current page number.
@property (nonatomic, assign, readonly) NSInteger currentIndex;
// Custom page control for scrollView, default is nil.
@property (nonatomic, strong, nullable) UIView<NELoopScrollViewPageControl> *pageControl;

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

- (void)reloadData;

@end

@protocol NELoopScrollViewPageControl <NSObject>

@property (nonatomic) NSInteger numberOfPages;
@property (nonatomic) NSInteger currentPage;

@end

@protocol NELoopScrollViewDataSource <NSObject>

- (NSInteger)numberOfItemsInScrollView:(NELoopScrollView *)scrollView;
- (nullable __kindof UIView *)scrollView:(NELoopScrollView *)scrollView cellForItemAtIndex:(NSInteger)index;

@end

@protocol NELoopScrollViewDelegate <NSObject>

@optional
- (void)scrollView:(NELoopScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index;
- (void)scrollView:(NELoopScrollView *)scrollView didScrollToIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
