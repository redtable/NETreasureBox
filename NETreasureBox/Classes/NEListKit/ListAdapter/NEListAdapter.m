//
//  NEListAdapter.m
//  NEListKit
//
//  Created by liang on 2020/2/4.
//  Copyright © 2020年 xdf. All rights reserved.
//

#import "NEListAdapter.h"
#import "NEListAdapter+UITableView.h"
#import "NEListAssert.h"
#import "NEListSectionController.h"
#import "NEListAdapter+Internal.h"

@interface NEListAdapter ()

@property (nonatomic, strong) UIView *emptyView;

@end

@implementation NEListAdapter

- (instancetype)init {
    UITableView *tableView;
    return [self initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        NEAssert(tableView, @"Arg `tableView` can not be nil!");

        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return self;
}

#pragma mark - NEListUpdater Methods
- (void)reloadData {
    NEAssertMainThread();
    
    [self addEmptyViewIfNecessary];
    [self.sectionControllers removeAllObjects];
    [self.tableView reloadData];
}

- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    NEAssertMainThread();
    
    [self addEmptyViewIfNecessary];
    
    for (NSInteger section = sections.firstIndex; section <= sections.lastIndex; section ++) {
        [self.sectionControllers removeObjectForKey:@(section)];
    }
    [self.tableView reloadSections:sections withRowAnimation:animation];
}

- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    NEAssertMainThread();

    [self addEmptyViewIfNecessary];
    
    for (NSIndexPath *indexPath in indexPaths) {
        [self.sectionControllers removeObjectForKey:@(indexPath.section)];
    }
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)performUpdateSectionControllers:(NSArray<NEListSectionController *> *)sectionControllers withRowAnimation:(UITableViewRowAnimation)animation {
    NEAssertMainThread();
    if (!sectionControllers.count) return;

    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    
    for (NEListSectionController *sectionController in sectionControllers) {
        if ([indexSet containsIndex:sectionController.section]) {
            continue;
        }
        [indexSet addIndex:sectionController.section];
    }
    [self reloadSections:indexSet withRowAnimation:animation];
}

- (void)performUpdateSectionController:(NEListSectionController *)sectionController atIndexs:(NSArray<NSNumber *> *)indexs withRowAnimation:(UITableViewRowAnimation)animation {
    NEAssertMainThread();
    if (!sectionController) return;
    if (![self.sectionControllers.allValues containsObject:sectionController]) return;

    NSMutableSet<NSIndexPath *> *indexPaths = [NSMutableSet set];
    NSInteger section = sectionController.section;
    
    for (NSNumber *index in indexs) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[index integerValue] inSection:section];
        [indexPaths addObject:indexPath];
    }
    [self reloadRowsAtIndexPaths:[indexPaths allObjects] withRowAnimation:animation];
}

- (void)addEmptyViewIfNecessary {
    if (![self.dataSource respondsToSelector:@selector(emptyViewForListAdapter:)]) return;
    
    if (_emptyView) {
        [_emptyView removeFromSuperview];
        _emptyView = nil;
    }
    
    if ([self.dataSource numberOfSectionControllersForListAdapter:self] <= 0) {
        self.emptyView = [self.dataSource emptyViewForListAdapter:self];
        self.emptyView.frame = CGRectMake(0.f,
                                          0.f,
                                          CGRectGetWidth(self.tableView.bounds),
                                          CGRectGetHeight(self.tableView.bounds));
        [self.tableView addSubview:self.emptyView];
    }
}

#pragma mark - NEListTableContext Methods
- (UITableViewCell *)dequeueReusableCellWithStyle:(UITableViewCellStyle)style forClass:(Class)aClass {
    NEAssert(aClass, @"Arg `aClass` can not be nil!");
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@_%@", aClass, [NSNumber numberWithInteger:style]];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[aClass alloc] initWithStyle:style reuseIdentifier:cellIdentifier];
    }
    NEAssert(cell, @"Cell can not be null!");
    return cell;
}

- (UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewForClass:(Class)aClass {
    NEAssert(aClass, @"Arg `aClass` can not be nil!");

    NSString *sectionViewIdentifier = NSStringFromClass(aClass);
    UITableViewHeaderFooterView *sectionView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionViewIdentifier];
    if (!sectionView) {
        sectionView = [[aClass alloc] initWithReuseIdentifier:sectionViewIdentifier];
    }
    NEAssert(sectionView, @"SectionView can not be null!");
    return sectionView;
}

#pragma mark - Getter Methods
- (NSMutableDictionary<NSNumber *, NEListSectionController *> *)sectionControllers {
    if (!_sectionControllers) {
        _sectionControllers = [NSMutableDictionary dictionary];
    }
    return _sectionControllers;
}

- (UIViewController *)viewController {
    if (!_viewController) {
        UIResponder *responder = _tableView;

        while (responder) {
            if ([responder isKindOfClass:[UIViewController class]]) {
                return (UIViewController *)responder;
            }
            responder = [responder nextResponder];
        }
    }
    return _viewController;
}

- (NSArray<NEListSectionController *> *)visibleSectionControllers {
    NEAssertMainThread();
    
    NSMutableSet *visibleSectionControllers = [NSMutableSet new];
    NSArray<NSIndexPath *> *visibleIndexPaths = [self.tableView.indexPathsForVisibleRows copy];
    
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        NEListSectionController *sectionController = [self.sectionControllers objectForKey:@(indexPath.section)];
//        NEAssert(sectionController != nil, @"Section controller nil for cell in section %ld", (long)indexPath.section);
        if (sectionController) {
            [visibleSectionControllers addObject:sectionController];
        }
    }
    return [visibleSectionControllers allObjects];
}

@end
