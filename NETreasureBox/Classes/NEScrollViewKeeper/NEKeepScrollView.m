//
//  NEKeepScrollView.m
//  NEStudentEmbeddedSDK
//
//  Created by liang on 2020/2/7.
//

#import "NEKeepScrollView.h"

@implementation NEKeepScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
