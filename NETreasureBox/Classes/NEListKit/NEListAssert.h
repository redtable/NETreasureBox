//
//  NEListAssert.h
//  NEListKit
//
//  Created by liang on 2020/2/4.
//  Copyright © 2020年 xdf. All rights reserved.
//

#ifndef NEListAssert_h
#define NEListAssert_h

#ifndef NEAssert
#define NEAssert(condition, ...) NSCAssert((condition) , ##__VA_ARGS__)
#endif

#ifndef NEParameterAssert
#define NEParameterAssert(condition) NEAssert((condition), @"Invalid parameter not satisfying: %@", @#condition)
#endif

#ifndef NEAssertMainThread
#define NEAssertMainThread() NEAssert(([NSThread isMainThread] == YES), @"You must operate on the main thread.")
#endif

#endif /* NEListAssert_h */
