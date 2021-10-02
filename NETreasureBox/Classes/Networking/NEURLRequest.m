//
//  NEURLRequest.m
//  WallGrass
//
//  Created by WangSen on 2020/12/4.
//

#import "NEURLRequest.h"
#import <AFNetworking/AFNetworking.h>
#import "NEURLResponse.h"
#import "NSError+NEMessage.h"
#import "NENetworkConfigurationManager.h"

@interface NEURLRequest ()

@property (nonatomic, copy) NSString * requestId;

@end

@implementation NEURLRequest

- (instancetype)init {
    if (self = [super init]) {
        _requestId = [[NSString stringWithFormat:@"%@_%u", [NSDate date], arc4random()] md5String];
        _requestMethod = NEURLRequestMethodGET;
        _sessionType = NEURLRequestSessionTypeHTTP;
    }
    return self;
}

+ (NEURLRequest *)requestWithBlock:(void(^)(NEURLRequest * request))block {
    NEURLRequest * request = [[NEURLRequest alloc] init];
    !block ?: block(request);
    return request;
}

- (instancetype)appendParameters:(NSDictionary <NSString *, id>* _Nullable (^)(void))parameters {
    if (!parameters) {
        return self;
    }
    
    NSDictionary <NSString *, id>* paramDic = parameters();
    NSMutableDictionary * mutableParamDic = [NSMutableDictionary new];
    for (NSString * key in paramDic.allKeys) {
        id value = [paramDic objectForKey:key];
        if ([value isKindOfClass:[NSString class]] && ((NSString *)value).length) {
            [mutableParamDic setObject:value forKey:key];
        } else if ([value isKindOfClass:[NSArray class]] && ((NSArray *)value).count) {
            [mutableParamDic setObject:value forKey:key];
        } else if ([value isKindOfClass:[NSDictionary class]] && ((NSDictionary *)value).count) {
            [mutableParamDic setObject:value forKey:key];
        }
    }
    self.parameters = [mutableParamDic yy_modelCopy];
    return self;
}

- (void)startRequestWithSuccess:(void(^)(NEURLResponse * response))success failure:(void(^)(NSError * error))failure {
    NSString * requestId = self.requestId;
    NSString * HTTPMethod = [self HTTPMethod];
    NSString * url = [self urlString];
    NSDictionary * parameters = [self requestParameters];
    NSDictionary * headers = [self headerParameters];
    if (![url hasSuffix:@"userlog/report.php"]) {
        NEAddNetworkLog(@"[NetSend] id=%@ | url=%@ | parameters=%@", requestId, url, parameters);
    }
    NSURLSessionDataTask * dataTask = [self.manager dataTaskWithHTTPMethod:HTTPMethod
                                                                 URLString:url
                                                                parameters:parameters
                                                                   headers:headers
                                                            uploadProgress:nil
                                                          downloadProgress:nil
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NEURLResponse * response = [NEURLResponse yy_modelWithJSON:responseObject];
        if (![response.data isKindOfClass:[NSDictionary class]]) {
#warning 这里约定好data是对象才可以
            response.data = [NSDictionary dictionary];
//            !failure ?: failure(NEErrorMake(1001, @"data should be dictionary !"));
//            return;
        }
        if (response.code == NEURLResponseCodeSuccess) {
            !success ?: success(response);
        } else {
            !failure ?: failure(response.error);
        }
        if (![url hasSuffix:@"userlog/report.php"]) {
            NEAddNetworkLog(@"[NetSuccess] id=%@ | response=%@", requestId, responseObject);
        }
        NSLog(@"===========\n\
              method = %@\n\
              url = %@\n\
              parameters = %@\n\
              responseObject = %@",
              HTTPMethod,
              url,
              parameters,
              responseObject
              );
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSMutableDictionary * userInfo = [NSMutableDictionary dictionaryWithDictionary:error.userInfo];
        [userInfo setObject:@(((NSHTTPURLResponse *)task.response).statusCode) forKey:@"statusCode"];
        !failure ?: failure([NSError errorWithDomain:error.domain code:error.code userInfo:userInfo]);
        if (![url hasSuffix:@"userlog/report.php"]) {
            NEAddNetworkLog(@"[NetError] id=%@ | error=%@", requestId, error);
        }
        NSLog(@"===========\n\
              method = %@\n\
              url = %@\n\
              parameters = %@\n\
              error = %@",
              HTTPMethod,
              url,
              parameters,
              error
              );
    }];
    [dataTask resume];
}

#pragma mark - Builder -

- (__kindof AFHTTPSessionManager *)manager {
    return [NENetworkConfigurationManager manager].sessionManager;
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer.timeoutInterval = 30.f;
//    if (self.sessionType == NEURLRequestSessionTypeJSON) {
//        manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:(NSJSONWritingOptions)0];
//    }
//    return manager;
}

- (NSString *)HTTPMethod {
    if (self.requestMethod == NEURLRequestMethodPOST) {
        return @"POST";
    }
    return @"GET";
}

- (NSString *)baseUrl {
    if ([_baseUrl isNotBlank]) {
        return _baseUrl;
    }
    return [NENetworkConfigurationManager manager].baseURL;
}

- (NSString *)urlString {
    NSAssert(self.baseUrl.length, @"base url cannot be nil");
    NSString * urlString = self.baseUrl;
    if ([urlString hasSuffix:@"/"]) {
        urlString = [urlString stringByReplacingCharactersInRange:NSMakeRange(urlString.length - 1, 1) withString:@""];
    }
    if (!self.urlPath.length) {
        return urlString;
    }
    if (![self.urlPath hasPrefix:@"/"]) {
        urlString = [urlString stringByAppendingString:@"/"];
    }
    urlString = [urlString stringByAppendingString:self.urlPath];
    return urlString;
}

- (NSDictionary *)requestParameters {
//    if ([self.parameters objectForKey:@"from"]) {
//        return self.parameters;
//    }
    NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithDictionary:self.parameters];
//    [parameters setObject:@"qtc" forKey:@"from"];
    [parameters addEntriesFromDictionary:[NENetworkConfigurationManager manager].publicParams];
    return parameters;
}

- (NSDictionary *)headerParameters {
    return nil;
}

@end
