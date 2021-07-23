//
//  NELogManager.m
//  WallGrass
//
//  Created by WangSen on 2021/1/22.
//

#import "NELogManager.h"
#import <MMKV/MMKV.h>

@interface NELogManager ()

@property (nonatomic, strong) MMKV * mmkv;
@property (nonatomic, copy) NSString * logKey;
@property (nonatomic, strong) NSMutableArray <NSDictionary *>* logs;

@end

@implementation NELogManager

+ (instancetype)manager {
    static NELogManager * _singletance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singletance = [[NELogManager alloc] init];
    });
    return _singletance;
}

- (instancetype)init {
    if (self = [super init]) {
        _logs = [NSMutableArray array];
        _mmkv = [MMKV mmkvWithID:@"greateconnection.log"];
        _logKey = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    }
    return self;
}

- (void)addActionLog:(NSString *)format,...NS_FORMAT_FUNCTION(1, 2) {
    va_list args;
    va_start(args, format);
    NSString * log = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    [self addLog:log type:NELogTypeAction];
}

- (void)addErrorLog:(NSString *)format,...NS_FORMAT_FUNCTION(1, 2) {
    va_list args;
    va_start(args, format);
    NSString * log = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    [self addLog:log type:NELogTypeError];
}

- (void)addNetworkLog:(NSString *)format,...NS_FORMAT_FUNCTION(1, 2) {
    va_list args;
    va_start(args, format);
    NSString * log = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    [self addLog:log type:NELogTypeNetwork];
}

- (void)addLog:(NSString *)log type:(NELogType)type {
    if (!log.length) {
        return;
    }
    NSDictionary * logInfo = @{
        @"time" : [[NSDate date] stringWithISOFormat] ?: @"",
        @"type" : @(type),
        @"info" : log ?: @"",
    };
    [self.logs addObject:logInfo];
    [self.mmkv setObject:self.logs forKey:self.logKey];
}

- (NSArray <NSDictionary *>*)logInfos {
    NSArray <NSString *>* allKeys = self.mmkv.allKeys;
    allKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj2 doubleValue] - [obj1 doubleValue];
    }];
    NSMutableArray * infos = [NSMutableArray arrayWithCapacity:allKeys.count];
    [allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray * value = [self.mmkv getObjectOfClass:[NSArray class] forKey:obj];
        [infos addObjectsFromArray:value];
    }];
    return [infos yy_modelCopy];
}

- (void)clear {
    NSArray <NSString *>* allKeys = self.mmkv.allKeys;
    [allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.mmkv removeValueForKey:obj];
    }];
}

- (void)autoClear {
    NSArray <NSString *>* allKeys = self.mmkv.allKeys;
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    [allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSTimeInterval logTime = [obj doubleValue];
        if (currentTime - logTime > NETimeOneHour * 36) {
            [self.mmkv removeValueForKey:obj];
        }
    }];
}

@end
