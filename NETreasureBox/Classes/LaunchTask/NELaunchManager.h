//
//  NELaunchManager.h
//  WallGrass
//
//  Created by WangSen on 2020/12/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NELaunchTaskType) {
    NELaunchTaskTypeSerial = 0,
    NELaunchTaskTypeConcurrent = 1,
};

@interface NELaunchManager : NSObject

+ (void)registerLaunchTaskNames:(NSArray <NSString *>*)taskNames type:(NELaunchTaskType)type;

+ (void)didFinishLaunchingWithOptions:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
