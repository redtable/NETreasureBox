//
//  NEListSectionController.h
//  NEListKit
//
//  Created by liang on 2020/2/4.
//  Copyright © 2020年 xdf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NEListAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NEListSectionControllerDataSource <NSObject>

@required
- (NSInteger)numberOfRows;
- (__kindof UITableViewCell *)cellForRowAtIndex:(NSInteger)index;

@end

@protocol NEListSectionControllerDelegate <NSObject>

@optional
- (void)willDisplayCell:(UITableViewCell *)cell forRowAtIndex:(NSInteger)index;
- (void)didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndex:(NSInteger)index;

- (CGFloat)heightForRowAtIndex:(NSInteger)index;
- (CGFloat)heightForHeader;
- (CGFloat)heightForFooter;

- (CGFloat)estimatedHeightForRowAtIndex:(NSInteger)index;
- (CGFloat)estimatedHeightForHeader;
- (CGFloat)estimatedHeightForFooter;

- (nullable UIView *)viewForHeader;
- (nullable UIView *)viewForFooter;

- (void)didSelectRowAtIndex:(NSInteger)index;

- (BOOL)canEditRowAtIndex:(NSInteger)index;
- (UITableViewCellEditingStyle)editingStyleAtIndex:(NSInteger)index;
- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndex:(NSInteger)index;

@end

@interface NEListSectionController : NSObject <NEListSectionControllerDataSource, NEListSectionControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, assign, readonly) NSInteger section;
@property (nonatomic, weak, readonly) id<NEListUpdater> updater;
@property (nonatomic, weak, readonly) id<NEListTableContext> tableContext;

- (void)didUpdateToObject:(id)object;

@end

NS_ASSUME_NONNULL_END
