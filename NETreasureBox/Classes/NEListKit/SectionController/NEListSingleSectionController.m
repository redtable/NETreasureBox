//
//  NEListSingleSectionController.m
//  NEListKit
//
//  Created by liang on 2020/2/4.
//  Copyright © 2020年 xdf. All rights reserved.
//

#import "NEListSingleSectionController.h"
#import "NEListAssert.h"

@interface NEListSingleSectionController ()

@property (nonatomic, strong, readonly) Class cellClass;
@property (nonatomic, strong, readonly) NEListCellConfigBlock configBlock;
@property (nonatomic, strong, readonly) NEListCellHeightBlock heightBlock;
@property (nonatomic, copy) NSArray *items; // DataSource for singleSectionController.

@end

@implementation NEListSingleSectionController

- (instancetype)initWithClass:(Class)cellClass
                  configBlock:(NEListCellConfigBlock)configBlock
                  heightBlock:(NEListCellHeightBlock)heightBlock {
    NEParameterAssert(cellClass != nil);
    NEParameterAssert(configBlock != nil);
    NEParameterAssert(heightBlock != nil);
    
    self = [super init];
    if (self) {
        _cellClass = cellClass;
        _configBlock = [configBlock copy];
        _heightBlock = [heightBlock copy];
    }
    return self;
}

#pragma mark - NEListSectionControllerDataSource Methods
- (NSInteger)numberOfRows {
    return self.items.count;
}

- (UITableViewCell *)cellForRowAtIndex:(NSInteger)index {
    UITableViewCell *cell = [self.tableContext dequeueReusableCellWithStyle:UITableViewCellStyleDefault forClass:self.cellClass];
    self.configBlock(index, cell);
    return cell;
}

#pragma mark - NEListSectionControllerDelegate Methods
- (CGFloat)heightForRowAtIndex:(NSInteger)index {
    return self.heightBlock(index);
}

- (void)didSelectRowAtIndex:(NSInteger)index {
    if (!self.selectionDelegate) return;
    
    SEL sel = @selector(sectionController:didSelectRowAtIndex:);
    if (![self.selectionDelegate respondsToSelector:sel]) return;

    [self.selectionDelegate sectionController:self didSelectRowAtIndex:index];
}

#pragma mark - NEListSectionController Methods
- (void)didUpdateToObject:(id)object {
    NSParameterAssert([object isKindOfClass:[NSArray class]] == YES);
    
    self.items = object;
}

@end
