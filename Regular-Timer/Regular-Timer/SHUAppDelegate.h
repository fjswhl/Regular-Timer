//
//  SHUAppDelegate.h
//  Regular-Timer
//
//  Created by Shuyu on 13-11-12.
//  Copyright (c) 2013年 Shuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHUAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
