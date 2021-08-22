//
//  NEScrollViewKeeper.h
//  NEStudentEmbeddedSDK
//
//  Created by liang on 2020/2/7.
//

#import <Foundation/Foundation.h>
#import "NEKeepScrollView.h"
#import "NEKeepTableView.h"
#import "NEKeepCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NEScrollViewKeeperDelegate <NSObject>

- (CGFloat)thresholdContentOffsetYForSuperScrollView:(UIScrollView *)scrollView;

@end

@interface NEScrollViewKeeper : NSObject

+ (NEScrollViewKeeper *)keeperWithIdentifier:(NSString *)identifier;
+ (void)firedKeeperWithIdentifier:(NSString *)identifier;

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, weak) id<NEScrollViewKeeperDelegate> delegate;

- (void)setSelectedIndex:(NSInteger)selectedIndex;

- (void)attachSuperScrollView:(UIScrollView *)scrollView;
- (void)detachSuperScrollView:(UIScrollView *)scrollView;

- (void)attachChildScrollView:(UIScrollView *)scrollView atIndex:(NSInteger)index;
- (void)detachChildScrollViewAtIndex:(NSInteger)index;

- (void)detachAllScrollViews;

- (void)superScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)childScrollViewDidScroll:(UIScrollView *)scrollView;

- (void)takeOverScrollIndicator;

@end

NS_ASSUME_NONNULL_END
