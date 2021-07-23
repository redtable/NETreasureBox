//
//  NEURLRequest.h
//  WallGrass
//
//  Created by WangSen on 2020/12/4.
//

#import <Foundation/Foundation.h>
#import "NEURLResponse.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NEURLRequestMethod) {
    NEURLRequestMethodGET = 0,
    NEURLRequestMethodPOST = 1,
};

typedef NS_ENUM(NSInteger, NEURLRequestSessionType) {
    NEURLRequestSessionTypeHTTP = 0,
    NEURLRequestSessionTypeJSON = 1,
};

@interface NEURLRequest : NSObject

@property (nonatomic, copy) NSString * baseUrl;
@property (nonatomic, copy) NSString * urlPath;
@property (nonatomic, copy) NSDictionary <NSString *, id>* parameters;
@property (nonatomic, assign) NEURLRequestMethod requestMethod; ///< default GET
@property (nonatomic, assign) NEURLRequestSessionType sessionType; ///< default HTTP

+ (NEURLRequest *)requestWithBlock:(void(^)(NEURLRequest * request))block;

- (instancetype)appendParameters:(NSDictionary <NSString *, id>* _Nullable (^)(void))parameters;

- (void)startRequestWithSuccess:(void(^)(NEURLResponse * response))success failure:(void(^)(NSError * error))failure;

@end

NS_ASSUME_NONNULL_END
