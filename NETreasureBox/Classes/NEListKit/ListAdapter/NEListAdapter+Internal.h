//
//  NEListAdapter+Internal.h
//  NEListKit
//
//  Created by liang on 2020/2/4.
//  Copyright © 2020年 xdf. All rights reserved.
//

#import "NEListAdapter.h"

@class NEListSectionController;

NS_ASSUME_NONNULL_BEGIN

@interface NEListAdapter ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NEListSectionController *> *sectionControllers;

@end

NS_ASSUME_NONNULL_END
