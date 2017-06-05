//
//  IconPickerViewController.h
//  ToDoList
//
//  Created by 鹏 付 on 05/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import <UIKit/UIKit.h>



@class IconPickerViewController;

@protocol IconPickerViewControllerDelegate <NSObject>

-(void)iconPicker:(IconPickerViewController*)controller didPickIcon:(NSString*)iconName ;

@end

@interface IconPickerViewController : UITableViewController

@property(nonatomic,weak)id<IconPickerViewControllerDelegate> delegate ;

@end
