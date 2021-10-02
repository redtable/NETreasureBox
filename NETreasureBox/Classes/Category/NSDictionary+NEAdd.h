//
//  NSDictionary+NEAdd.h
//  NETreasureBox
//
//  Created by WangSen on 2021/10/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (NEAdd)

- (NSArray *)ne_arrayForKey:(NSString *)key;

- (NSDictionary *)ne_dictionaryForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
