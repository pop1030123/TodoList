//
//  AllListsViewController.h
//  ToDoList
//
//  Created by 鹏 付 on 04/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"

@interface AllListsViewController : UITableViewController<ListDetailViewControllerDelegate>

-(void)saveCheckLists;
@end
