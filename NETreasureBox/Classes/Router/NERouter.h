//
//  NERouter.h
//  WallGrass
//
//  Created by WangSen on 2020/12/23.
//

#import <Foundation/Foundation.h>
#import "UIViewController+NEParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface NERouter : NSObject

+ (BOOL)openPage:(NSString *)pageName;

+ (BOOL)openPage:(NSString *)pageName params:(NSDictionary * _Nullable)params;

@end

NS_ASSUME_NONNULL_END
