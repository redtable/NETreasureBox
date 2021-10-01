//
//  NENetworkConfigurationManager.m
//  WallGrass
//
//  Created by WangSen on 2021/2/3.
//

#import "NENetworkConfigurationManager.h"

@interface NENetworkConfigurationManager ()

@property (nonatomic, strong) AFHTTPSessionManager * sessionManager;

@end

@implementation NENetworkConfigurationManager

+ (instancetype)manager {
    static NENetworkConfigurationManager * _singletance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singletance = [[NENetworkConfigurationManager alloc] init];
    });
    return _singletance;
}

- (instancetype)init {
    if (self = [super init]) {
//        _baseURL = NEBaseURL;
    }
    return self;
}

- (__kindof AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer.timeoutInterval = 30.f;
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:(NSJSONWritingOptions)0];
    }
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer.timeoutInterval = 30.f;
////    if (self.sessionType == NEURLRequestSessionTypeJSON) {
//        manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:(NSJSONWritingOptions)0];
////    }
    return _sessionManager;
}

- (void)switchBaseURL {
//    if ([_baseURL isEqualToString:NEBaseURL]) {
//        _baseURL = NEBaseBackUpURL;
//    } else if ([_baseURL isEqualToString:NEBaseBackUpURL]){
//        _baseURL = NEBaseURL;
//    } else {
//        _baseURL = NEBaseURL;
//    }
}

@end
