//
//  NESegmentedControl.h
//  Student_iPad
//
//  Created by liang on 2019/6/11.
//  Copyright © 2019 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NESegmentedControl;
@class NESegmentedControlSegment;

NS_ASSUME_NONNULL_BEGIN

@protocol NESegmentedControlDataSource <NSObject>

- (NSInteger)numberOfItemsInSegmentedControl:(NESegmentedControl *)segmentedControl;
- (__kindof NESegmentedControlSegment *)segmentedControl:(NESegmentedControl *)segmentedControl segmentForItemAtIndex:(NSInteger)index;

@optional
- (__kindof NESegmentedControlSegment *)segmentedControl:(NESegmentedControl *)segmentedControl segmentForSelectedItemAtIndex:(NSInteger)index;

@end

@protocol NESegmentedControlDelegate <UIScrollViewDelegate>

- (CGFloat)segmentedControl:(NESegmentedControl *)segmentedControl widthForItemAtIndex:(NSInteger)index;

@optional
- (CGFloat)segmentedControl:(NESegmentedControl *)segmentedControl widthForSelectedItemAtIndex:(NSInteger)index;
- (void)segmentedControl:(NESegmentedControl *)segmentedControl didSelectItemAtIndex:(NSInteger)index;

- (nullable UIView *)flagForSegmentedControl:(NESegmentedControl *)segmentedControl;
- (CGSize)segmentedControl:(NESegmentedControl *)segmentedControl sizeForFlagAtIndex:(NSInteger)index;
- (CGPoint)segmentedControl:(NESegmentedControl *)segmentedControl offsetForFlagAtIndex:(NSInteger)index;
- (CGFloat)minimumInteritemSpacingForSegmentedControl:(NESegmentedControl *)segmentedControl;

@end

@interface NESegmentedControl : UIView

@property (nonatomic, weak) id<NESegmentedControlDataSource> dataSource;
@property (nonatomic, weak) id<NESegmentedControlDelegate> delegate;

@property (nonatomic, assign, readonly) NSUInteger selectedIndex;
@property (nonatomic, strong, readonly) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL alwaysBounceHorizontal; // Default is NO.
@property (nonatomic, assign) BOOL bounces; // Default is YES.

- (void)reloadData;

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;

- (__kindof NESegmentedControlSegment *)dequeueReusableSegmentOfClass:(Class)aClass forIndex:(NSInteger)index;

@end

@interface NESegmentedControlSegment : UICollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;

@end

NS_ASSUME_NONNULL_END
