//
//  NEKeepTableView.m
//  NEStudentEmbeddedSDK
//
//  Created by liang on 2020/2/7.
//

#import "NEKeepTableView.h"

@implementation NEKeepTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
