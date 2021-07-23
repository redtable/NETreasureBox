//
//  NSError+NEMessage.h
//  WallGrass
//
//  Created by WangSen on 2020/12/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define NEDefaultError NEErrorMake(NEErrorCodeDefaultError, NELocalizedString(@"默认错误message"))

FOUNDATION_EXTERN NSString * const kNEErrorDomain;

static inline NSError * NEErrorMake(NSInteger code, NSString * _Nullable message) {
    message = message?:@"";
    if ([message isKindOfClass:[NSDictionary class]]) {
        message = ((NSDictionary *)message).jsonStringEncoded;
    } else if ([message isKindOfClass:[NSArray class]]) {
        message = ((NSArray *)message).jsonStringEncoded;
    }
    return [NSError errorWithDomain:kNEErrorDomain code:code userInfo:@{@"message":message}];
}

@interface NSError (NEMessage)

@property (nonatomic, readonly, copy) NSString * msgDescription;

//@property (nonatomic, readonly, copy) NSString * showCode; ///< 展示码
//@property (nonatomic, readonly, copy) NSString * message;

@end

NS_ASSUME_NONNULL_END
