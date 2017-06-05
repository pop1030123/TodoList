//
//  CheckList.h
//  ToDoList
//
//  Created by 鹏 付 on 04/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckList : NSObject<NSCoding>


@property(nonatomic ,copy)NSString* name ;
@property(nonatomic,strong)NSMutableArray* items ;

-(int)countUnDoneItem ;

@end
