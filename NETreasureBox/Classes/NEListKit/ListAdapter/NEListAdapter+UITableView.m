//
//  NEListAdapter+UITableView.m
//  NEListKit
//
//  Created by liang on 2020/2/4.
//  Copyright © 2020年 xdf. All rights reserved.
//

#import "NEListAdapter+UITableView.h"
#import "NEListAdapter+Internal.h"
#import "NEListSectionController.h"
#import "NEListSectionController+Internal.h"

static CGFloat const kUITableViewCellDefaultHeight = 44.f;

@implementation NEListAdapter (UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.dataSource) return 0;
    if (![self.dataSource respondsToSelector:@selector(numberOfSectionControllersForListAdapter:)]) return 0;
    
    return [self.dataSource numberOfSectionControllersForListAdapter:self];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NEListSectionController *sectionController = [self sectionControllerForSection:section];
    return [sectionController numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NEListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    return [sectionController cellForRowAtIndex:indexPath.row];
}
#pragma clang diagnostic pop

// Get sectionController from self.sectionControllers with section, if failed, get from dataSource method <sectionControllerForSection:> again.
- (NEListSectionController *)sectionControllerForSection:(NSInteger)section {
    // At `NEListSectionController.m`
    extern void NEListSectionControllerPushThread(id<NEListUpdater>, id<NEListTableContext>, NSInteger);
    extern void NEListSectionControllerPopThread(void);
    
    NEListSectionController *sectionController = [self.sectionControllers objectForKey:@(section)];
    if (!sectionController) {
        NEListSectionControllerPushThread(self, self, section);
        sectionController = [self.dataSource listAdapter:self sectionControllerForSection:section];
        self.sectionControllers[@(section)] = sectionController;
        NEListSectionControllerPopThread();
    }

    if (sectionController.section != section) {
        NEListSectionControllerPushThread(self, self, section);
        [sectionController _threadContextDidUpdate];
        NEListSectionControllerPopThread();
    }

    return sectionController;
}

@end

@implementation NEListAdapter (UITableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NEListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(heightForRowAtIndex:)]) {
        return [sectionController heightForRowAtIndex:indexPath.row];
    }
    return kUITableViewCellDefaultHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NEListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(estimatedHeightForRowAtIndex:)]) {
        return [sectionController estimatedHeightForRowAtIndex:indexPath.row];
    }
    if (@available(iOS 11.0, *)) {
        return 0.01f;
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NEListSectionController *sectionController = [self sectionControllerForSection:section];
    if ([sectionController respondsToSelector:@selector(heightForHeader)]) {
        return [sectionController heightForHeader];
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    NEListSectionController *sectionController = [self sectionControllerForSection:section];
    if ([sectionController respondsToSelector:@selector(estimatedHeightForHeader)]) {
        return [sectionController estimatedHeightForHeader];
    }
    if (@available(iOS 11.0, *)) {
        return 0.01f;
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NEListSectionController *sectionController = [self sectionControllerForSection:section];
    if ([sectionController respondsToSelector:@selector(heightForFooter)]) {
        return [sectionController heightForFooter];
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    NEListSectionController *sectionController = [self sectionControllerForSection:section];
    if ([sectionController respondsToSelector:@selector(estimatedHeightForFooter)]) {
        return [sectionController estimatedHeightForFooter];
    }
    if (@available(iOS 11.0, *)) {
        return 0.01f;
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NEListSectionController *sectionController = [self sectionControllerForSection:section];
    if ([sectionController respondsToSelector:@selector(viewForHeader)]) {
        return [sectionController viewForHeader];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NEListSectionController *sectionController = [self sectionControllerForSection:section];
    if ([sectionController respondsToSelector:@selector(viewForFooter)]) {
        return [sectionController viewForFooter];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NEListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(didSelectRowAtIndex:)]) {
        [sectionController didSelectRowAtIndex:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NEListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(willDisplayCell:forRowAtIndex:)]) {
        [sectionController willDisplayCell:cell forRowAtIndex:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!(indexPath.section < self.sectionControllers.count)) {
        // Tells the delegate that the specified cell was removed from the table.
        return;
    }
    NEListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(didEndDisplayingCell:forRowAtIndex:)]) {
        [sectionController didEndDisplayingCell:cell forRowAtIndex:indexPath.row];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NEListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(canEditRowAtIndex:)]) {
        return [sectionController canEditRowAtIndex:indexPath.row];
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    NEListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(editingStyleAtIndex:)]) {
        return [sectionController editingStyleAtIndex:indexPath.row];
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NEListSectionController *sectionController = [self sectionControllerForSection:indexPath.section];
    if ([sectionController respondsToSelector:@selector(commitEditingStyle:forRowAtIndex:)]) {
        [sectionController commitEditingStyle:editingStyle forRowAtIndex:indexPath.row];
    }
}

@end

@implementation NEListAdapter (UIScrollViewDelegate)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    id<UIScrollViewDelegate> scrollDelegate = self.scrollDelegate;
    if ([scrollDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [scrollDelegate scrollViewDidScroll:scrollView];
    }
    
    NSArray<NEListSectionController *> *visibleSectionControllers = [self visibleSectionControllers];
    for (NEListSectionController *sectionController in visibleSectionControllers) {
        if ([sectionController respondsToSelector:@selector(scrollViewDidScroll:)]) {
            [sectionController scrollViewDidScroll:scrollView];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    id<UIScrollViewDelegate> scrollDelegate = self.scrollDelegate;
    if ([scrollDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [scrollDelegate scrollViewWillBeginDragging:scrollView];
    }
    
    NSArray<NEListSectionController *> *visibleSectionControllers = [self visibleSectionControllers];
    for (NEListSectionController *sectionController in visibleSectionControllers) {
        if ([sectionController respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
            [sectionController scrollViewWillBeginDragging:scrollView];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    id<UIScrollViewDelegate> scrollDelegate = self.scrollDelegate;
    if ([scrollDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [scrollDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
    
    NSArray<NEListSectionController *> *visibleSectionControllers = [self visibleSectionControllers];
    for (NEListSectionController *sectionController in visibleSectionControllers) {
        if ([sectionController respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
            [sectionController scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    id<UIScrollViewDelegate> scrollDelegate = self.scrollDelegate;
    if ([scrollDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [scrollDelegate scrollViewDidEndDecelerating:scrollView];
    }
    
    NSArray<NEListSectionController *> *visibleSectionControllers = [self visibleSectionControllers];
    for (NEListSectionController *sectionController in visibleSectionControllers) {
        if ([sectionController respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
            [sectionController scrollViewDidEndDecelerating:scrollView];
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    SEL sel = @selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:);
    
    id<UIScrollViewDelegate> scrollDelegate = self.scrollDelegate;
    if ([scrollDelegate respondsToSelector:sel]) {
        [scrollDelegate scrollViewWillEndDragging:scrollView
                                     withVelocity:velocity
                              targetContentOffset:targetContentOffset];
    }
    
    NSArray<NEListSectionController *> *visibleSectionControllers = [self visibleSectionControllers];
    for (NEListSectionController *sectionController in visibleSectionControllers) {
        if ([sectionController respondsToSelector:sel]) {
            [sectionController scrollViewWillEndDragging:scrollView
                                            withVelocity:velocity
                                     targetContentOffset:targetContentOffset];
        }
    }
}

@end
