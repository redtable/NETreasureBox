//
//  NEListSectionController.m
//  NEListKit
//
//  Created by liang on 2020/2/4.
//  Copyright © 2020年 xdf. All rights reserved.
//

#import "NEListSectionController.h"
#import "NEListAssert.h"
#import "NEListSectionController+Internal.h"

static NSString *const kNEListSectionControllerContextStackKey = @"kNEListSectionControllerContextStackKey";

@interface NEListSectionControllerThreadContext : NSObject

@property (nonatomic, weak) id<NEListUpdater> updater;
@property (nonatomic, weak) id<NEListTableContext> tableContext;
@property (nonatomic, assign) NSInteger section;

@end

@implementation NEListSectionControllerThreadContext

- (instancetype)init {
    self = [super init];
    if (self) {
        _section = NSNotFound;
    }
    return self;
}

@end

static NSMutableArray<NEListSectionControllerThreadContext *> *threadContextStack(void) {
    NEAssertMainThread();
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSMutableArray *stack = threadDictionary[kNEListSectionControllerContextStackKey];
    if (!stack) {
        stack = [NSMutableArray array];
        threadDictionary[kNEListSectionControllerContextStackKey] = stack;
    }
    return stack;
}

static NEListSectionControllerThreadContext *NEListSectionControllerTopThread(void) {
    NSMutableArray *stack = threadContextStack();
    return stack.lastObject;
}

void NEListSectionControllerPushThread(id<NEListUpdater> updater, id<NEListTableContext> tableContext, NSInteger section) {
    NEListSectionControllerThreadContext *context = [[NEListSectionControllerThreadContext alloc] init];
    context.updater = updater;
    context.tableContext = tableContext;
    context.section = section;
    [threadContextStack() addObject:context];
}

void NEListSectionControllerPopThread(void) {
    NSMutableArray *stack = threadContextStack();
    [stack removeLastObject];
}

@implementation NEListSectionController

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"%@ dealloc.", self);
#endif
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _threadContextDidUpdate];
    }
    return self;
}

- (void)_threadContextDidUpdate {
    NEListSectionControllerThreadContext *context = NEListSectionControllerTopThread();
    _updater = context.updater;
    _tableContext = context.tableContext;
    _section = context ? context.section : NSNotFound;
}

- (NSInteger)numberOfRows {
    NEAssert(NO, @"This method must be override, (%s).", __FUNCTION__);
    return 0;
}

- (UITableViewCell *)cellForRowAtIndex:(NSInteger)index {
    NEAssert(NO, @"This method must be override, (%s).", __FUNCTION__);
    return nil;
}

#pragma mark - NEListSectionControllerOverride
- (void)didUpdateToObject:(id)object {
    NEAssert(NO, @"This method must be override, (%s).", __FUNCTION__);
}

@end
