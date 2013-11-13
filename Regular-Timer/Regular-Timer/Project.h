//
//  Project.h
//  Regular-Timer
//
//  Created by Shuyu on 13-11-14.
//  Copyright (c) 2013年 Shuyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Project : NSManagedObject

@property (nonatomic, retain) NSString * projectName;
@property (nonatomic, retain) NSNumber * projectID;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSNumber * continuedHour;
@property (nonatomic, retain) NSString * remarkText;
@property (nonatomic, retain) NSDate * remindTime;
@property (nonatomic, retain) NSNumber * needRemind;
@property (nonatomic, retain) NSNumber * remindCircle;

@end
