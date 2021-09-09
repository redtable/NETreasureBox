//
//  NESegmentedPageController.m
//  NEStudentEmbeddedSDK
//
//  Created by liang on 2020/1/15.
//

#import "NESegmentedPageController.h"
#import "NEDefaultSegmentedControlSegment.h"

static CGFloat const kSegmentedControlDefaultHeight = 50.f;

@interface NESegmentedPageController () <NESegmentedControlDelegate, NESegmentedControlDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NESegmentedControl *segmentedControl;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation NESegmentedPageController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadViewIfNeeded];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commitInit];
    [self createViewHierarchy];
    [self layoutContentViews];
}

- (void)commitInit {
    self.view.backgroundColor = [UIColor clearColor];

    if (@available(iOS 11, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)createViewHierarchy {
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.collectionView];
}

- (void)layoutContentViews {    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(kSegmentedControlDefaultHeight);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - Public Methods
- (void)removeAllChildViewControllers {
    NSArray<UIViewController *> *childViewControllers = [self.childViewControllers copy];
    
    for (UIViewController *childViewController in childViewControllers) {
        [childViewController removeFromParentViewController];
        [childViewController.view removeFromSuperview];
    }
    [self reloadData];
}

- (void)reloadData {
    if (self.selectedIndex > self.childViewControllers.count - 1 && self.childViewControllers.count > 0) {
        [self setSelectedIndex:0 animated:NO];
    }
    
    [self.segmentedControl reloadData];
    [self.collectionView reloadData];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated {
    if (!self.childViewControllers.count) { return; }
    
    [self.segmentedControl setSelectedIndex:selectedIndex animated:animated];
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:animated];
    CGFloat offsetX = selectedIndex * ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).itemSize.width;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0.f) animated:animated];
    if ([self.delegate respondsToSelector:@selector(segmentedPageController:didSelectItemAtIndex:)]) {
        [self.delegate segmentedPageController:self didSelectItemAtIndex:selectedIndex];
    }
}

#pragma mark - NESegmentedControlProtocol
- (NSInteger)numberOfItemsInSegmentedControl:(NESegmentedControl *)segmentedControl {
    return self.childViewControllers.count;
}

- (NESegmentedControlSegment *)segmentedControl:(NESegmentedControl *)segmentedControl segmentForItemAtIndex:(NSInteger)index {
    Class segmentClass;
    if ([self.delegate respondsToSelector:@selector(segmentedPageController:segmentClassForItemAtIndex:)]) {
        segmentClass = [self.delegate segmentedPageController:self segmentClassForItemAtIndex:index];
    }
    if (!segmentClass) {
//        return nil;
        segmentClass = [NEDefaultSegmentedControlSegment class];
    }
    
    NESegmentedControlSegment *segment = [segmentedControl dequeueReusableSegmentOfClass:segmentClass forIndex:index];
    
    if ([self.delegate respondsToSelector:@selector(setSegment:atIndex:)]) {
        [self.delegate setSegment:segment atIndex:index];
    }
    return segment;
}

- (NESegmentedControlSegment *)segmentedControl:(NESegmentedControl *)segmentedControl segmentForSelectedItemAtIndex:(NSInteger)index {
    Class segmentClass;
    if ([self.delegate respondsToSelector:@selector(segmentedPageController:segmentClassForSelectedItemAtIndex:)]) {
        segmentClass = [self.delegate segmentedPageController:self segmentClassForSelectedItemAtIndex:index];
    }
    if (!segmentClass) {
//        return nil;
        segmentClass = [NEDefaultSegmentedControlSelectedSegment class];
    }
    
    NESegmentedControlSegment *segment = [segmentedControl dequeueReusableSegmentOfClass:segmentClass forIndex:index];
    
    if ([self.delegate respondsToSelector:@selector(setSegment:atSelectedIndex:)]) {
        [self.delegate setSegment:segment atSelectedIndex:index];
    }
    return segment;
}

- (CGFloat)segmentedControl:(NESegmentedControl *)segmentedControl widthForItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(segmentedPageController:widthForItemAtIndex:)]) {
        return [self.delegate segmentedPageController:self widthForItemAtIndex:index];
    }
    return 0.f;
}

- (CGFloat)segmentedControl:(NESegmentedControl *)segmentedControl widthForSelectedItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(segmentedPageController:widthForSelectedItemAtIndex:)]) {
        return [self.delegate segmentedPageController:self widthForSelectedItemAtIndex:index];
    }
    return [self segmentedControl:segmentedControl widthForItemAtIndex:index];
}

- (void)segmentedControl:(NESegmentedControl *)segmentedControl didSelectItemAtIndex:(NSInteger)index {
    CGFloat offsetX = index * ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).itemSize.width;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0.f) animated:NO];

    if ([self.delegate respondsToSelector:@selector(segmentedPageController:didSelectItemAtIndex:)]) {
        [self.delegate segmentedPageController:self didSelectItemAtIndex:index];
    }
}

- (UIView *)flagForSegmentedControl:(NESegmentedControl *)segmentedControl {
    if ([self.delegate respondsToSelector:@selector(flagForSegmentedControlInSegmentedPageController:)]) {
        return [self.delegate flagForSegmentedControlInSegmentedPageController:self];
    }
    
    UIView *flag = [[UIView alloc] init];
    flag.layer.cornerRadius = 1.9f;
    flag.backgroundColor = RGBColor(0x1FB895);
    return flag;
}

- (CGSize)segmentedControl:(NESegmentedControl *)segmentedControl sizeForFlagAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(segmentedPageController:sizeForFlagAtIndex:)]) {
        return [self.delegate segmentedPageController:self sizeForFlagAtIndex:index];
    }
    return CGSizeMake(20.f, 3.f);
}

- (CGPoint)segmentedControl:(NESegmentedControl *)segmentedControl offsetForFlagAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(segmentedPageController:offsetForFlagAtIndex:)]) {
        return [self.delegate segmentedPageController:self offsetForFlagAtIndex:index];
    }
    CGFloat height = CGRectGetHeight(segmentedControl.bounds) ?: kSegmentedControlDefaultHeight;
    return CGPointMake(0.f, height - 7.f);
}

- (CGFloat)minimumInteritemSpacingForSegmentedControl:(NESegmentedControl *)segmentedControl {
    if ([self.delegate respondsToSelector:@selector(minimumInteritemSpacingForSegmentedControlInSegmentedPageController:)]) {
        return [self.delegate minimumInteritemSpacingForSegmentedControlInSegmentedPageController:self];
    }
    return 0.f;
}

#pragma mark - UICollectionViewProtocol
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    if (cell.contentView.subviews.count > 0) {    
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    if (self.childViewControllers.count > indexPath.item) {
        UIViewController *controller = self.childViewControllers[indexPath.item];
        [cell.contentView addSubview:controller.view];

        [controller.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView != self.collectionView) { return; }
    
    NSInteger selectedIndex = self.collectionView.contentOffset.x / CGRectGetWidth(self.view.bounds);
    [self.segmentedControl setSelectedIndex:selectedIndex animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(segmentedPageController:didScrollToItemAtIndex:)]) {
        [self.delegate segmentedPageController:self didScrollToItemAtIndex:selectedIndex];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView != self.collectionView) { return; }
    
    NSInteger selectedIndex = self.collectionView.contentOffset.x / CGRectGetWidth(self.view.bounds);
    [self.segmentedControl setSelectedIndex:selectedIndex animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(segmentedPageController:didScrollToItemAtIndex:)]) {
        [self.delegate segmentedPageController:self didScrollToItemAtIndex:selectedIndex];
    }
}

#pragma mark - Getter Methods
- (NESegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[NESegmentedControl alloc] init];
        _segmentedControl.dataSource = self;
        _segmentedControl.delegate = self;
        _segmentedControl.scrollView.contentInset = UIEdgeInsetsMake(0, 11.f, 0, -11.f);
    }
    return _segmentedControl;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGRect rect = CGRectMake(0,
                                 129.f,
                                 CGRectGetWidth(self.view.bounds),
                                 CGRectGetHeight(self.view.bounds) - 129.f);

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0.f;
        layout.itemSize = rect.size;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.directionalLockEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    }
    return _collectionView;
}

- (NSInteger)selectedIndex {
    if (!self.childViewControllers.count) {
        return -1;
    }
    return self.segmentedControl.selectedIndex;
}

- (UIViewController *)selectedViewController {
    if (!self.childViewControllers.count) {
        return nil;
    }
    return self.childViewControllers[self.segmentedControl.selectedIndex];
}

@end
