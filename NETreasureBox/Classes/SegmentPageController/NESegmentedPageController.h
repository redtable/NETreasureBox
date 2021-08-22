//
//  NESegmentedPageController.h
//  NEStudentEmbeddedSDK
//
//  Created by liang on 2020/1/15.
//

#import <UIKit/UIKit.h>
#import <NESegmentedControl.h>
//#import "NEDefaultSegmentedControlSegment.h"

@class NESegmentedPageController;

NS_ASSUME_NONNULL_BEGIN

@protocol NESegmentedPageControllerDelegate <NSObject>

- (void)setSegment:(__kindof NESegmentedControlSegment *)segment atIndex:(NSInteger)index;
- (void)setSegment:(__kindof NESegmentedControlSegment *)segment atSelectedIndex:(NSInteger)index;
- (CGFloat)segmentedPageController:(NESegmentedPageController *)segmentedPageController widthForItemAtIndex:(NSInteger)index;

@optional
- (CGFloat)segmentedPageController:(NESegmentedPageController *)segmentedPageController widthForSelectedItemAtIndex:(NSInteger)index;
- (void)segmentedPageController:(NESegmentedPageController *)segmentedPageController didSelectItemAtIndex:(NSInteger)index;
- (void)segmentedPageController:(NESegmentedPageController *)segmentedPageController didScrollToItemAtIndex:(NSInteger)index;

// Flag
- (nullable UIView *)flagForSegmentedControlInSegmentedPageController:(NESegmentedPageController *)segmentedPageController;
- (CGSize)segmentedPageController:(NESegmentedPageController *)segmentedPageController sizeForFlagAtIndex:(NSInteger)index;
- (CGPoint)segmentedPageController:(NESegmentedPageController *)segmentedPageController offsetForFlagAtIndex:(NSInteger)index;
- (CGFloat)minimumInteritemSpacingForSegmentedControlInSegmentedPageController:(NESegmentedPageController *)segmentedPageController;

// Segment class
- (nullable Class)segmentedPageController:(NESegmentedPageController *)segmentedPageController segmentClassForItemAtIndex:(NSInteger)index;
- (nullable Class)segmentedPageController:(NESegmentedPageController *)segmentedPageController segmentClassForSelectedItemAtIndex:(NSInteger)index;

@end

@interface NESegmentedPageController : UIViewController

@property (nonatomic, weak) id<NESegmentedPageControllerDelegate> delegate;

@property (nonatomic, strong, readonly) NESegmentedControl *segmentedControl;
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@property (readonly) NSInteger selectedIndex;
@property (readonly, nullable) __kindof UIViewController *selectedViewController;

- (void)removeAllChildViewControllers;
- (void)reloadData;

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
