//
//  NENetworkConfigurationManager.h
//  WallGrass
//
//  Created by WangSen on 2021/2/3.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface NENetworkConfigurationManager : NSObject

@property (nonatomic, copy) NSString * baseURL;
@property (nonatomic, copy) NSDictionary * publicParams;

+ (instancetype)manager;

- (__kindof AFHTTPSessionManager *)sessionManager;

- (void)switchBaseURL;

@end

NS_ASSUME_NONNULL_END
