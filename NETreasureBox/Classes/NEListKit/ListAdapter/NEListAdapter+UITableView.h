//
//  NEListAdapter+UITableView.h
//  NEListKit
//
//  Created by liang on 2020/2/4.
//  Copyright © 2020年 xdf. All rights reserved.
//

#import "NEListAdapter.h"

@interface NEListAdapter (UITableViewDataSource) <UITableViewDataSource>
@end

@interface NEListAdapter (UITableViewDelegate) <UITableViewDelegate>
@end

@interface NEListAdapter (UIScrollViewDelegate)
@end
