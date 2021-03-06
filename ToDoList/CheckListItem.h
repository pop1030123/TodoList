//
//  CheckListItem.h
//  ToDoList
//
//  Created by 鹏 付 on 31/05/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckListItem : NSObject<NSCoding>


@property(nonatomic ,copy) NSString *text ;
@property(nonatomic ,assign) BOOL checked ;

@property(nonatomic ,copy)NSDate* dueDate ;
@property(nonatomic ,assign)BOOL shouldRemind ;
@property(nonatomic ,assign)NSInteger itemId ;


-(void)toggleChecked;

-(void)scheduleNotification;
@end
