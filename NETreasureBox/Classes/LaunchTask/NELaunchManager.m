//
//  NELaunchManager.m
//  WallGrass
//
//  Created by WangSen on 2020/12/21.
//

#import "NELaunchManager.h"
#import "NELaunchTaskProtocol.h"

@interface NELaunchManager ()

@property (nonatomic, copy) NSDictionary * launchOptions;
@property (nonatomic, copy) NSArray <id<NELaunchTaskProtocol>>* serialTasks;
@property (nonatomic, copy) NSArray <id<NELaunchTaskProtocol>>* concurrentTasks;

@end

@implementation NELaunchManager

+ (instancetype)manager {
    static NELaunchManager * _singleInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleInstance = [[NELaunchManager alloc] init];
    });
    return _singleInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        [self collectTasks];
    }
    return self;
}

- (void)collectTasks {
    NSArray * serialTaskNames = @[
        @"NERootWindowMakeLaunchTask",
        @"NEPrivatePolicyLaunchTask",
//        @"NEServiceQualityLaunchTask",
//        @"NEAccountInitLaunchTask",
//        @"NEVPNStatusKeepLaunchTask",
//        @"NEConnectConfigurationUpdateLaunchTask",
    ];
    NSArray * concurrentTaskNames = @[
//        @"NEValidPeriodCheckerLaunchTask",
//        @"NEPurchaseLaunchTask",
    ];
    self.serialTasks = [self tasksWithNames:serialTaskNames];
    self.concurrentTasks = [self tasksWithNames:concurrentTaskNames];
}

- (NSArray <id<NELaunchTaskProtocol>>*)tasksWithNames:(NSArray <NSString *>*)taskNames {
    NSMutableArray * tasks = [NSMutableArray arrayWithCapacity:taskNames.count];
    [taskNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id<NELaunchTaskProtocol> task = [[NSClassFromString(obj) alloc] init];
        [tasks addObject:task];
    }];
    return tasks;
}

- (void)didFinishLaunchingWithOptions:(NSDictionary *)options {
//    NSLog(@"--- ---> 启动");
    self.launchOptions = options;
    [self executeSerialLaunchTasks];
}

#pragma mark - Execute Tasks -

- (void)executeConcurrentLaunchTasks {
    dispatch_queue_t queue = dispatch_queue_create("com.greatconnect.asyncLaunchTaskQueue", DISPATCH_QUEUE_CONCURRENT);
    [self.concurrentTasks enumerateObjectsUsingBlock:^(id<NELaunchTaskProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_async(queue, ^{
            [obj applicationDidLaunchingWithOptions:self.launchOptions completion:nil];
        });
    }];
}

- (void)executeSerialLaunchTasks {
    static NSInteger serialIndex = 0;
    if (serialIndex < self.serialTasks.count) {
        id<NELaunchTaskProtocol> task = [self.serialTasks objectOrNilAtIndex:serialIndex];
        serialIndex++;
        @weakify(self);
//        NSLog(@"--- ---> %@ 开始", NSStringFromClass([task class]));
        [task applicationDidLaunchingWithOptions:self.launchOptions completion:^{
            @strongify(self);
//            NSLog(@"--- ---> %@ 结束", NSStringFromClass([task class]));
            [self executeSerialLaunchTasks];
        }];
    } else {
//        NSLog(@"--- ---> 结束");
        [self executeConcurrentLaunchTasks];
    }
}

@end
