//
//  NEURLResponse.m
//  WallGrass
//
//  Created by WangSen on 2020/12/4.
//

#import "NEURLResponse.h"

NSInteger const NEURLResponseCodeSuccess = 0; ///< 成功
NEURLResponseResult const NEURLResponseResultSuccess = @"success"; ///< 成功
NEURLResponseResult const NEURLResponseResultFailed = @"fail"; ///< 失败
NEURLResponseResult const NEURLResponseResultLink = @"moveto"; ///< 跳转link

@implementation NEURLResponse

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
        @"data" : @"data",
        @"code" : @"code",
        @"result" : @"result",
        @"message" : @"detail",
    };
}

- (NSError *)error {
    NSString * description = self.message;
    if (self.data && [self.data isKindOfClass:[NSString class]]) {
        description = [NSString stringWithFormat:@"%@(%zd)", self.data, self.code];
    }
    return [NSError errorWithDomain:@"resp.error.domain" code:self.code userInfo:@{
        NSLocalizedDescriptionKey : description,
    }];
}

@end
