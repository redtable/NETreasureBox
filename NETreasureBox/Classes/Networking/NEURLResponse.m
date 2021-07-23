//
//  NEURLResponse.m
//  WallGrass
//
//  Created by WangSen on 2020/12/4.
//

#import "NEURLResponse.h"

NEURLResponseResult const NEURLResponseResultSuccess = @"success"; ///< 成功
NEURLResponseResult const NEURLResponseResultFailed = @"fail"; ///< 失败
NEURLResponseResult const NEURLResponseResultLink = @"moveto"; ///< 跳转link

@implementation NEURLResponse

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
        @"data" : @"info",
        @"code" : @"code",
        @"result" : @"result",
    };
}

- (NSError *)error {
    NSString * description = @"";
    if (self.data && [self.data isKindOfClass:[NSString class]]) {
        description = self.data;
    }
    return [NSError errorWithDomain:@"resp.error.domain" code:self.code userInfo:@{
        NSLocalizedDescriptionKey : description,
    }];
}

@end
