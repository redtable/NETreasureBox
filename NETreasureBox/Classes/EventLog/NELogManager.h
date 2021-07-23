//
//  NELogManager.h
//  WallGrass
//
//  Created by WangSen on 2021/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NELogType) {
    NELogTypeAction = 0, ///< 行为类型
    NELogTypeNetwork = 1, ///< 网络类型
    NELogTypeError = 2, ///< 错误类型
};

@interface NELogManager : NSObject

@property (nonatomic, readonly, copy) NSArray <NSDictionary *>* logInfos;

+ (instancetype)manager;

- (void)addActionLog:(NSString *)format,...NS_FORMAT_FUNCTION(1, 2);
- (void)addErrorLog:(NSString *)format,...NS_FORMAT_FUNCTION(1, 2);
- (void)addNetworkLog:(NSString *)format,...NS_FORMAT_FUNCTION(1, 2);

- (void)clear;
- (void)autoClear;

@end

NS_ASSUME_NONNULL_END
