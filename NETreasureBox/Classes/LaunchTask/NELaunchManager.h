//
//  NELaunchManager.h
//  WallGrass
//
//  Created by WangSen on 2020/12/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NELaunchManager : NSObject

+ (instancetype)manager;

- (void)didFinishLaunchingWithOptions:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
