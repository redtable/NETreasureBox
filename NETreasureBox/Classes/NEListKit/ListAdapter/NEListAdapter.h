//
//  NEListAdapter.h
//  NEListKit
//
//  Created by liang on 2020/2/4.
//  Copyright © 2020年 xdf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NEListAdapter;
@class NEListSectionController;

NS_ASSUME_NONNULL_BEGIN

@protocol NEListAdapterDataSource <NSObject>

- (NSInteger)numberOfSectionControllersForListAdapter:(NEListAdapter *)listAdapter;
- (NEListSectionController *)listAdapter:(NEListAdapter *)listAdapter sectionControllerForSection:(NSInteger)section;

@optional
- (UIView *)emptyViewForListAdapter:(NEListAdapter *)listAdapter;

@end

@protocol NEListUpdater <NSObject>

- (void)reloadData;
- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

- (void)performUpdateSectionControllers:(NSArray<NEListSectionController *> *)sectionControllers withRowAnimation:(UITableViewRowAnimation)animation;
- (void)performUpdateSectionController:(NEListSectionController *)sectionController atIndexs:(NSArray<NSNumber *> *)indexs withRowAnimation:(UITableViewRowAnimation)animation;

@end

@protocol NEListTableContext <NSObject>

@property (nullable, readonly) UIViewController *viewController;
@property (readonly) UITableView *tableView;

- (__kindof UITableViewCell *)dequeueReusableCellWithStyle:(UITableViewCellStyle)style forClass:(Class)aClass;
- (__kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewForClass:(Class)aClass;

@end

@interface NEListAdapter : NSObject <NEListUpdater, NEListTableContext>

@property (nonatomic, weak) id<NEListAdapterDataSource> dataSource;
@property (nonatomic, weak, nullable) id<UIScrollViewDelegate> scrollDelegate;

@property (nonatomic, weak, readonly) UITableView *tableView;
@property (nonatomic, weak, nullable) UIViewController *viewController;
@property (readonly) NSArray<NEListSectionController *> *visibleSectionControllers;

- (instancetype)initWithTableView:(UITableView *)tableView NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
