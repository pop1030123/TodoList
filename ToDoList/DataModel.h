//
//  DataModel.h
//  ToDoList
//
//  Created by 鹏 付 on 04/06/2017.
//  Copyright © 2017 鹏 付. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property(nonatomic ,strong)NSMutableArray* lists ;

-(void)saveCheckLists ;

-(void)setIndexOfCheckList:(NSInteger)index ;

-(NSInteger)indexOfCheckList;

-(void)sortList ;

@end
