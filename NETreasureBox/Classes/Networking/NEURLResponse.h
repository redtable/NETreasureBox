//
//  NEURLResponse.h
//  WallGrass
//
//  Created by WangSen on 2020/12/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSInteger const NEURLResponseCodeSuccess;

typedef NSString * NEURLResponseResult;
FOUNDATION_EXTERN NEURLResponseResult const NEURLResponseResultSuccess; ///< 成功
FOUNDATION_EXTERN NEURLResponseResult const NEURLResponseResultFailed; ///< 失败
FOUNDATION_EXTERN NEURLResponseResult const NEURLResponseResultLink; ///< 跳转link

@interface NEURLResponse : NSObject <YYModel>

@property (nonatomic, copy) NSDictionary * data;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NEURLResponseResult result;
@property (nonatomic, readonly, strong) NSError * error;

@end

NS_ASSUME_NONNULL_END
