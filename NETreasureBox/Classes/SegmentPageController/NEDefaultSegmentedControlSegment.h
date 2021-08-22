//
//  NEDefaultSegmentedControlSegment.h
//  NEStudentEmbeddedSDK
//
//  Created by liang on 2020/1/15.
//

#import "NESegmentedControl.h"

NS_ASSUME_NONNULL_BEGIN

@interface NEDefaultSegmentedControlSegment : NESegmentedControlSegment

- (void)setText:(NSString *)text;
- (void)setMarkCount:(NSInteger)markCount;
- (void)setMarkText:(NSString * _Nullable)markText;

+ (CGFloat)widthByText:(NSString *)text;

@end

@interface NEDefaultSegmentedControlSelectedSegment : NEDefaultSegmentedControlSegment

@end

NS_ASSUME_NONNULL_END
