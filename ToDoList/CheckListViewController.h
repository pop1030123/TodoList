//
//  ViewController.h
//  ToDoList
//
//  Created by 鹏 付 on 31/05/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"


@class CheckList;

@interface CheckListViewController : UITableViewController<ItemDetailViewControllerDelegate>

@property(nonatomic ,strong) CheckList* checkList ;

@end

