//
//  ItemDetailViewController.h
//  ToDoList
//
//  Created by 鹏 付 on 02/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ItemDetailViewController ;
@class CheckListItem ;

@protocol ItemDetailViewControllerDelegate <NSObject>

-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController*)controller ;
-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(CheckListItem*)item ;
-(void)itemDetailViewController:(ItemDetailViewController*)controller didFinishEditingItem:(CheckListItem*)item ;

@end

@interface ItemDetailViewController : UITableViewController<UITextFieldDelegate>

@property(weak ,nonatomic)id<ItemDetailViewControllerDelegate> delegate ;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@property(weak ,nonatomic)IBOutlet UISwitch* switchControl ;
@property(weak ,nonatomic)IBOutlet UILabel* dueDateLabel ;

@property(strong ,nonatomic)CheckListItem* itemToEdit ;

@end
