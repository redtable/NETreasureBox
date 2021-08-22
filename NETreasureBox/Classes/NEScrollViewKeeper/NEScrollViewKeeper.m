//
//  NEScrollViewKeeper.m
//  NEStudentEmbeddedSDK
//
//  Created by liang on 2020/2/7.
//

#import "NEScrollViewKeeper.h"

@interface NEScrollViewKeeper () {
    BOOL _takeOverScrollIndicator;
}

@property (class, strong, readonly) NSMutableDictionary<NSString *, NEScrollViewKeeper *> *keepers;
@property (nonatomic, weak) UIScrollView *superScrollView;
@property (nonatomic, strong) NSMapTable<NSNumber *, UIScrollView *> *childScrollViews;
@property (nonatomic, assign) BOOL superScrollViewScrollEnable;
@property (nonatomic, assign) BOOL childScrollViewScrollEnable;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation NEScrollViewKeeper

+ (NSMutableDictionary<NSString *,NEScrollViewKeeper *> *)keepers {
    static NSMutableDictionary *_keepers;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keepers = [NSMutableDictionary dictionary];
    });
    return _keepers;
}

+ (NEScrollViewKeeper *)keeperWithIdentifier:(NSString *)identifier {
    NSAssert(identifier.length, @"The argument `identifier` is invalid!");
    NEScrollViewKeeper *keeper = self.keepers[identifier];
    if (keeper) { return keeper; }
    
    keeper = [[NEScrollViewKeeper alloc] initWithIdentifier:identifier];
    self.keepers[identifier] = keeper;
    return keeper;
}

+ (void)firedKeeperWithIdentifier:(NSString *)identifier {
    NSAssert(identifier.length, @"The argument `identifier` is invalid!");
    self.keepers[identifier] = nil;
}

- (instancetype)initWithIdentifier:(NSString *)identifier {
    self = [super init];
    if (self) {
        _identifier = [identifier copy];
        _superScrollViewScrollEnable = YES;
        _childScrollViewScrollEnable = NO;
    }
    return self;
}

- (void)attachSuperScrollView:(UIScrollView *)scrollView {
    self.superScrollView = scrollView;
}

- (void)detachSuperScrollView:(UIScrollView *)scrollView {
    self.superScrollView = nil;
}

- (void)attachChildScrollView:(UIScrollView *)scrollView atIndex:(NSInteger)index {
    [self.childScrollViews setObject:scrollView forKey:@(index)];
}

- (void)detachChildScrollViewAtIndex:(NSInteger)index {
    [self.childScrollViews setObject:nil forKey:@(index)];
}

- (void)detachAllScrollViews {
    self.superScrollView = nil;
    [self.childScrollViews removeAllObjects];
}

- (void)superScrollViewDidScroll:(UIScrollView *)scrollView {
    UIScrollView *superScrollView = self.superScrollView;
    UIScrollView *childScrollView = [self.childScrollViews objectForKey:@(self.selectedIndex)];
    if (!superScrollView || !childScrollView) { return; }

    CGFloat threshold = [self.delegate thresholdContentOffsetYForSuperScrollView:superScrollView];

    if (superScrollView.contentOffset.y >= threshold) { // Arrive top
        if (superScrollView.scrollEnabled) {
            superScrollView.contentOffset = CGPointMake(0.f, threshold);
            superScrollView.scrollEnabled = NO;
        }
        
        if (self.superScrollViewScrollEnable) {
            self.superScrollViewScrollEnable = NO;
            self.childScrollViewScrollEnable = YES;
        }
    } else {
        if (!self.superScrollViewScrollEnable) {
            superScrollView.contentOffset = CGPointMake(0.f, threshold);
        }
    }
    
    if (_takeOverScrollIndicator) {
        superScrollView.showsVerticalScrollIndicator = self.superScrollViewScrollEnable ? YES : NO;
    }
}

- (void)childScrollViewDidScroll:(UIScrollView *)scrollView {
    UIScrollView *superScrollView = self.superScrollView;
    UIScrollView *childScrollView = [self.childScrollViews objectForKey:@(self.selectedIndex)];
    if (!superScrollView || !childScrollView) { return; }

    if (!self.childScrollViewScrollEnable) {
        childScrollView.contentOffset = CGPointMake(0.f, -childScrollView.contentInset.top);
    }
    
    if (childScrollView.contentOffset.y <= -childScrollView.contentInset.top) {
        self.childScrollViewScrollEnable = NO;
        self.superScrollViewScrollEnable = YES;
        superScrollView.scrollEnabled = YES;
        childScrollView.contentOffset = CGPointMake(0.f, -childScrollView.contentInset.top);
    }
    
    if (_takeOverScrollIndicator) {
        childScrollView.showsVerticalScrollIndicator = self.childScrollViewScrollEnable ? YES : NO;
    }
}

- (void)takeOverScrollIndicator {
    _takeOverScrollIndicator = YES;
}

#pragma mark - Setter Methods
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    CGFloat threshold = [self.delegate thresholdContentOffsetYForSuperScrollView:self.superScrollView];
    self.childScrollViewScrollEnable = (self.superScrollView.contentOffset.y >= threshold);
    self.superScrollViewScrollEnable = !self.childScrollViewScrollEnable;
}

#pragma mark - Getter Methods
- (NSMapTable<NSNumber *,UIScrollView *> *)childScrollViews {
    if (!_childScrollViews) {
        _childScrollViews = [NSMapTable strongToWeakObjectsMapTable];
    }
    return _childScrollViews;
}

@end
