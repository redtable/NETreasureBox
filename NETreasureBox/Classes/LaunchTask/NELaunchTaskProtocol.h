//
//  NELaunchTaskProtocol.h
//  WallGrass
//
//  Created by WangSen on 2020/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NELaunchTaskProtocol <NSObject>

- (void)applicationDidLaunchingWithOptions:(NSDictionary *)launchOptions completion:(nullable void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
