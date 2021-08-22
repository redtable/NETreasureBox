//
//  NEListSingleSectionController.h
//  NEListKit
//
//  Created by liang on 2020/2/4.
//  Copyright © 2020年 xdf. All rights reserved.
//

#import "NEListSectionController.h"

@class NEListSingleSectionController;

NS_ASSUME_NONNULL_BEGIN

typedef void (^NEListCellConfigBlock)(NSInteger index, __kindof UITableViewCell *cell);
typedef CGFloat (^NEListCellHeightBlock)(NSInteger index);

@protocol NEListSingleSectionControllerDelegate <NSObject>

- (void)sectionController:(NEListSingleSectionController *)sectionController didSelectRowAtIndex:(NSInteger)index;

@end

@interface NEListSingleSectionController : NEListSectionController

- (instancetype)initWithClass:(Class)cellClass
                  configBlock:(NEListCellConfigBlock)configBlock
                  heightBlock:(NEListCellHeightBlock)heightBlock;

@property (nonatomic, weak) id<NEListSingleSectionControllerDelegate> selectionDelegate;

@end

NS_ASSUME_NONNULL_END
