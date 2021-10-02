//
//  NSDictionary+NEAdd.m
//  NETreasureBox
//
//  Created by WangSen on 2021/10/2.
//

#import "NSDictionary+NEAdd.h"

@implementation NSDictionary (NEAdd)

- (NSArray *)ne_arrayForKey:(NSString *)key {
    if (![key isNotBlank]) {
        return [NSArray array];
    }
    id value = [self objectForKey:key];
    if (![value isKindOfClass:[NSArray class]]) {
        return [NSArray array];
    }
    return value;
}

- (NSDictionary *)ne_dictionaryForKey:(NSString *)key {
    if (![key isNotBlank]) {
        return [NSDictionary dictionary];
    }
    id value = [self objectForKey:key];
    if (![value isKindOfClass:[NSDictionary class]]) {
        return [NSDictionary dictionary];
    }
    return value;
}

@end
