//
//  NEKeepCollectionView.m
//  NEStudentEmbeddedSDK
//
//  Created by liang on 2020/2/7.
//

#import "NEKeepCollectionView.h"

@implementation NEKeepCollectionView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
