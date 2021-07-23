//
//  NSError+NEMessage.m
//  WallGrass
//
//  Created by WangSen on 2020/12/4.
//

#import "NSError+NEMessage.h"

NSString * const kNEErrorDomain = @"com.greatconnect.errorDomain";

@implementation NSError (NEMessage)

//- (NSString *)message {
//    return [self.userInfo objectForKey:@"message"];
//}

- (NSString *)msgDescription {
    NSString * message = @"";
    if (self.userInfo) {
        message = [self.userInfo objectForKey:@"message"];
    }
    if (![message isNotBlank]) {
        message = NELocalizedString(@"网络请求失败提示");
    }
    return [NSString stringWithFormat:@"%@(%@:%ld)", message, NELocalizedString(@"错误码文案"), self.code];
}

//- (NSString *)showCode {
//    if (![self.domain isEqualToString:kNEErrorDomain]) {
//        return @"";
//    }
//    if (self.code == NEErrorCodeDefaultError) {
//        return @"";
//    }
//    return [NSString stringWithFormat:@"(%@:%ld)", NELocalizedString(@"错误码文案"), self.code];
//}

@end
